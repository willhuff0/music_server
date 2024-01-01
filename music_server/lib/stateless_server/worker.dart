// ignore_for_file: unused_field

import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:music_server/stateless_server/server.dart';

class WorkerManager {
  final Isolate _isolate;
  final Stream<dynamic> fromIsolateStream;
  final SendPort toIsolatePort;

  late final StreamSubscription _fromIsolateSubscription;

  WorkerManager._(this._isolate, this.fromIsolateStream, this.toIsolatePort) {
    _fromIsolateSubscription = fromIsolateStream.listen((message) {});
  }

  static Future<WorkerManager> start(WorkerLaunchArgs args, {String? debugName}) async {
    final fromIsolatePort = ReceivePort();
    final fromIsolatePortBroadcast = fromIsolatePort.asBroadcastStream();
    final isolate = await Isolate.spawn<(SendPort, WorkerLaunchArgs, String?)>(
      (message) => WorkerIsolate.spawn(message.$1, message.$2, debugName: message.$3),
      (fromIsolatePort.sendPort, args, debugName),
      debugName: debugName,
    );
    final toIsolatePort = await fromIsolatePortBroadcast.first;
    return WorkerManager._(isolate, fromIsolatePortBroadcast, toIsolatePort);
  }

  Future<void> shutdown() async {
    toIsolatePort.send('shutdown');
  }
}

class WorkerIsolate {
  final Worker _worker;
  final Stream<dynamic> _fromManagerStream;
  final SendPort _toManagerPort;

  late final StreamSubscription _fromManagerSubscription;

  WorkerIsolate._(this._worker, this._fromManagerStream, this._toManagerPort) {
    _fromManagerSubscription = _fromManagerStream.listen((message) {
      switch (message) {
        case 'shutdown':
          _shutdown();
          break;
      }
    });
  }

  static Future<WorkerIsolate> spawn(SendPort toManagerPort, WorkerLaunchArgs args, {String? debugName}) async {
    final fromManagerPort = ReceivePort();
    toManagerPort.send(fromManagerPort.sendPort);
    final fromManagerStream = fromManagerPort.asBroadcastStream();

    final worker = await args.start(args, fromManagerStream, toManagerPort, debugName: debugName);

    return WorkerIsolate._(worker, fromManagerStream, toManagerPort);
  }

  Future<void> _shutdown() async {
    _worker.shutdown();
    _fromManagerSubscription.cancel();
  }
}

abstract interface class Worker {
  Future<void> shutdown();
}

class WorkerLaunchArgs {
  Future<Worker> Function(WorkerLaunchArgs args, Stream<dynamic> fromManagerStream, SendPort toManagerPort, {String? debugName}) start;
  final ServerConfig config;

  WorkerLaunchArgs({required this.start, required this.config});
}

class WorkerLaunchArgsWithAuthentication extends WorkerLaunchArgs {
  final Uint8List privateKey;

  WorkerLaunchArgsWithAuthentication({required super.start, required super.config, required this.privateKey});
}
