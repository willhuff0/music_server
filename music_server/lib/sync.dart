import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:isar/isar.dart';
import 'package:music_server/custom_router.dart';
import 'package:music_server/database/sync_session.dart';
import 'package:music_server/music_server.dart';
import 'package:music_server/stateless_server/stateless_server.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

var _syncSessionWorkerManagers = <WorkerManager>[];

Future<void> startDispatchingSyncSessionWorkers(Isar isar, MusicServerPaths paths, MusicServerConfig config) async {
  // start workers
  _syncSessionWorkerManagers = await Future.wait(Iterable.generate(
      config.numSyncSessionWorkers,
      (index) => WorkerManager.start(
          SyncSessionWorkerLaunchArgs(
            start: SyncSessionWorker.start,
            config: config,
            paths: paths,
            syncSessionPort: 8082 + index,
          ),
          debugName: 'Sync session Worker $index')));

  // delete all sync session leftover from when the server last shutdown
  isar.writeTxnSync(() {
    for (final oldSyncSession in isar.syncSessions.where().findAllSync()) {
      isar.syncSessions.deleteSync(oldSyncSession.isarId);
    }
  });

  var nextWorkerIndex = 0;
  isar.syncSessions.where().workReceivedEqualTo(false).watch().listen((syncSessions) {
    isar.writeTxnSync(() {
      for (final syncSession in syncSessions) {
        final request = StartSyncSession(
          isarId: syncSession.isarId,
          userId: syncSession.userId,
          authorizedClients: syncSession.authorizedClients,
        );
        _syncSessionWorkerManagers[nextWorkerIndex].toIsolatePort.send(request);

        syncSession.workReceived = true;
        syncSession.port = 8082 + nextWorkerIndex;
        isar.syncSessions.putSync(syncSession);

        nextWorkerIndex++;
        if (nextWorkerIndex >= config.numTranscodeWorkers) nextWorkerIndex = 0;
      }
    });
  });
  nextWorkerIndex++;
  if (nextWorkerIndex >= config.numSyncSessionWorkers) nextWorkerIndex = 0;

  stdout.writeln('Dispatching sync session workers');
}

Future<void> shutdownSyncSessionWorkers() async {
  await Future.wait(_syncSessionWorkerManagers.map((e) => e.shutdown()));
}

class StartSyncSession {
  final Id isarId;
  final String userId;
  final List<String> authorizedClients;

  StartSyncSession({required this.isarId, required this.userId, required this.authorizedClients});
}

class SyncSessionWorker implements Worker {
  final String? _debugName;

  final Isar _isar;

  final CustomRouter _router;
  final HttpServer _server;

  late final StreamSubscription _fromManagerStreamSubscription;
  final SendPort toManagerPort;

  final _sessions = <String, SyncSessionServer>{};

  SyncSessionWorker._(this._debugName, this._isar, this._router, this._server, Stream<dynamic> fromManagerStream, this.toManagerPort) {
    _fromManagerStreamSubscription = fromManagerStream.listen((event) {
      if (event is StartSyncSession) {
        _startSession(event);
      }
    });
  }

  static Future<Worker> start(WorkerLaunchArgs args, Stream<dynamic> fromManagerStream, SendPort toManagerPort, {String? debugName}) async {
    if (args is! SyncSessionWorkerLaunchArgs) throw Exception('SyncSessionWorker must be started with SyncSessionWorkerLaunchArgs');

    final isar = openIsarDatabaseOnIsolate(args.paths);

    final router = CustomRouter();
    final handler = Pipeline().addMiddleware(logRequests(logger: debugName != null ? (message, isError) => print('[$debugName] $message') : null)).addHandler(router.call);
    final server = await serve(handler, args.config.address, args.syncSessionPort, shared: false);

    return SyncSessionWorker._(debugName, isar, router, server, fromManagerStream, toManagerPort);
  }

  Future<void> _startSession(StartSyncSession request) async {
    print('[$_debugName] starting sync session (${request.isarId}): ${request.userId}, ${request.authorizedClients}');

    final session = SyncSessionServer(
      isar: _isar,
      isarId: request.isarId,
      userId: request.userId,
      authorizedClients: request.authorizedClients,
      onClose: () => _endSession(request.userId),
    );
    _router.all('/${request.userId}', session.handle);
    _sessions[request.userId] = session;
  }

  void _endSession(String userId) {
    _router.remove('/$userId');
    final server = _sessions.remove(userId);
    print('[$_debugName] sync session ended (${server?.isarId}): $userId, ${server?.authorizedClients}');
  }

  @override
  Future<void> shutdown() async {
    await _fromManagerStreamSubscription.cancel();
    if (_sessions.isNotEmpty) {
      stdout.writeln('$_debugName is waiting for ${_sessions.length} session(s) to close');
      await Future.wait(_sessions.values.map((e) => e.endSession()));
    }
    await _server.close();
  }
}

class SyncSessionWorkerLaunchArgs extends WorkerLaunchArgs {
  final MusicServerPaths paths;
  final int syncSessionPort;

  SyncSessionWorkerLaunchArgs({
    required super.start,
    required super.config,
    required this.paths,
    required this.syncSessionPort,
  });
}

class SyncSessionServer {
  final Isar isar;
  final Id isarId;
  final String userId;
  List<String> authorizedClients;
  final void Function() onClose;

  final List<WebSocketChannel> clients = [];

  late final Handler _handler;

  late final StreamSubscription _isarListenSubscription;

  SyncSessionServer({required this.isar, required this.isarId, required this.userId, required this.authorizedClients, required this.onClose}) {
    _handler = webSocketHandler(_onConnection);
    _isarListenSubscription = isar.syncSessions.watchObject(isarId).listen(_onSessionUpdated);
  }

  void _onSessionUpdated(SyncSession? newSession) {
    if (newSession == null) {
      endSession();
      return;
    }
    authorizedClients = newSession.authorizedClients;
  }

  FutureOr<Response> handle(Request request) {
    final ip = (request.context['shelf.io.connection_info'] as HttpConnectionInfo?)?.remoteAddress.address;
    if (!authorizedClients.any((element) => element == ip)) return Response.unauthorized('');
    return _handler(request);
  }

  void _onConnection(WebSocketChannel client, _) {
    clients.add(client);
    client.stream.listen((request) => _onRequest(client, request)).onDone(() {
      clients.remove(client);
      if (clients.isEmpty) {
        endSession();
      }
    });
  }

  void _onRequest(WebSocketChannel client, dynamic request) {
    final timestamp = DateTime.timestamp();

    if (request is! String) {
      print('Malformed request: $request');
      return;
    }

    dynamic json;
    try {
      json = jsonDecode(request);
    } catch (e) {
      print('Malformed request: $request, $e');
      return;
    }

    switch (json['method']) {
      case 'time':
        client.sink.add(jsonEncode({
          'method': 'time',
          'received': timestamp.microsecondsSinceEpoch,
          'sent': DateTime.timestamp().microsecondsSinceEpoch,
        }));
        break;
      case 'call':
        final call = json['call'];
        final params = json['params'];
        final response = jsonEncode({
          'method': 'call',
          'call': call,
          if (params != null) 'params': params,
        });
        for (final client in clients) {
          client.sink.add(response);
        }
        break;
      case 'callTimeSensitive':
        final call = json['call'];
        final effective = DateTime.timestamp().add(Duration(milliseconds: 1000)).microsecondsSinceEpoch;
        final response = jsonEncode({
          'method': 'callTimeSensitive',
          'call': call,
          'effective': effective,
        });
        for (final client in clients) {
          client.sink.add(response);
        }
        break;
      case 'end':
        endSession();
        break;
    }
  }

  Future<void> endSession() async {
    _isarListenSubscription.cancel();
    isar.writeTxnSync(() => isar.syncSessions.deleteSync(isarId));
    await Future.wait(clients.map((e) => e.sink.close()));
    onClose();
  }
}
