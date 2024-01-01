import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:music_server/stateless_server/stateless_server.dart';

// This needs to be rethought

class CustomWorker implements Worker {
  final CustomWorkerLaunchArgs _args;
  final HttpServer _server;
  final Router _router;
  final CustomThreadData _threadData;

  CustomWorker._(this._server, this._router, this._threadData, this._args) {
    for (final customHandler in _args.customHandlers) {
      addCustomHandler(customHandler);
    }
  }

  static Future<Worker> start(WorkerLaunchArgs args, Stream<dynamic> fromManagerStream, SendPort toManagerPort, {String? debugName}) async {
    if (args is! CustomWorkerLaunchArgs) throw Exception('CustomWorker must be started with CustomWorkerLaunchArgs');

    final threadData = await args.createThreadData();

    final router = Router();
    final handler = Pipeline().addMiddleware(logRequests(logger: debugName != null ? (message, isError) => print('[$debugName] $message') : null)).addHandler(router.call);
    final server = await serve(handler, args.config.address, args.config.port, shared: true);

    return CustomWorker._(server, router, threadData, args);
  }

  void addCustomHandler(CustomHandlerBase customHandler) => _router.all(customHandler.path, customHandler.createHandler(_threadData));

  @override
  Future shutdown() async {
    await _server.close();
    _args.onClose(_threadData);
  }
}

abstract class CustomHandlerBase<TThreadData extends CustomThreadData> {
  final String path;

  CustomHandlerBase({required this.path});

  FutureOr<Response> Function(Request request) createHandler(TThreadData threadData);
}

class CustomHandler<TThreadData extends CustomThreadData> extends CustomHandlerBase<TThreadData> {
  final FutureOr<Response> Function(Request request, TThreadData threadData) handle;

  CustomHandler({required super.path, required this.handle});

  @override
  FutureOr<Response> Function(Request request) createHandler(TThreadData threadData) => (request) => handle(request, threadData);
}

class CustomHandlerAuthRequired<TClaims extends IdentityTokenClaims, TThreadData extends CustomThreadDataWithAuth<TClaims>> extends CustomHandlerBase<TThreadData> {
  final FutureOr<Response> Function(Request request, TThreadData threadData, IdentityToken<TClaims> identityToken) handle;

  CustomHandlerAuthRequired({required super.path, required this.handle});

  @override
  FutureOr<Response> Function(Request request) createHandler(TThreadData threadData) => (request) {
        final encodedToken = request.headers['token'];
        if (encodedToken == null) return Response.forbidden('');
        final identityToken = threadData.identityTokenAuthority.verifyAndDecodeToken(encodedToken);
        if (identityToken == null) return Response.forbidden('');

        return handle(request, threadData, identityToken);
      };
}

abstract class CustomThreadData {}

class CustomThreadDataWithAuth<TClaims extends IdentityTokenClaims> extends CustomThreadData {
  final IdentityTokenAuthority<TClaims> identityTokenAuthority;

  CustomThreadDataWithAuth({required this.identityTokenAuthority});
}

class CustomWorkerLaunchArgs extends WorkerLaunchArgs {
  final FutureOr<CustomThreadData> Function() createThreadData;
  final List<CustomHandlerBase> customHandlers;
  final FutureOr<void> Function(CustomThreadData threadData) onClose;

  CustomWorkerLaunchArgs({
    required super.config,
    required this.createThreadData,
    required this.onClose,
    this.customHandlers = const [],
  }) : super(start: CustomWorker.start);
}
