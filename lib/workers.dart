import 'dart:async';
import 'dart:io';

import 'package:isar/isar.dart';
import 'package:music_server/database.dart';
import 'package:music_server/database/user.dart';
import 'package:stateless_server/stateless_server.dart';
import 'package:uuid/data.dart';
import 'package:uuid/rng.dart';
import 'package:uuid/uuid.dart';

final _secureUuid = Uuid(goptions: GlobalOptions(CryptoRNG()));

IdentityToken? verifyIdentityToken(IdentityTokenAuthority identityTokenAuthority, Request request) {
  final encodedToken = request.headers['token'];
  if (encodedToken == null) return null;
  final identityToken = identityTokenAuthority.verifyAndDecodeToken(encodedToken);
  if (identityToken == null) return null;
  return identityToken;
}

class MusicAuthenticationWorker implements Worker {
  final HttpServer _server;

  final IdentityTokenAuthority _identityTokenAuthority;
  final Isar _isar;

  MusicAuthenticationWorker._(this._server, this._identityTokenAuthority, this._isar, Router router) {
    router
      ..get('/auth/status', _statusHandler)
      ..put('/auth/createUser', _createUserHandler)
      ..put('/auth/startSession', _startSession)
      ..get('/auth/getName', _getNameHandler);
  }

  static Future<Worker> start(WorkerLaunchArgs args, {String? debugName}) async {
    if (args is! WorkerLaunchArgsWithAuthentication) throw Exception('AuthenticationWorker must be started with WorkerLaunchArgsWithAuthentication');

    final router = Router();
    final handler = Pipeline().addMiddleware(logRequests(logger: debugName != null ? (message, isError) => print('[$debugName] $message') : null)).addHandler(router.call);
    final server = await serve(handler, args.config.address, args.config.port, shared: true);

    final identityTokenAuthority = IdentityTokenAuthority.initializeOnIsolate(args.config, args.privateKey);
    final isar = await openIsarDatabaseOnIsolate();

    return MusicAuthenticationWorker._(server, identityTokenAuthority, isar, router);
  }

  @override
  Future shutdown() async {
    await _server.close();
  }

  FutureOr<Response> _statusHandler(Request request) {
    return Response.ok('Operational');
  }

  Future<Response> _createUserHandler(Request request) async {
    final name = request.headers['name'];
    if (name == null) return Response.badRequest();
    if (!_validateNewName(name)) return Response.badRequest();

    final email = request.headers['email'];
    if (email == null) return Response.badRequest();
    if (!_validateNewEmail(email)) return Response.badRequest();

    final password = request.headers['password'];
    if (password == null) return Response.badRequest();
    if (!_validateNewPassword(password)) return Response.badRequest();

    final hashedUserPassword = await HashedUserPassword.createNew(password);

    final userId = _secureUuid.v7();

    final dbUser = User.create(
      id: userId,
      name: name,
      email: email,
      password: hashedUserPassword,
    );

    final clientIpAddress = (request.context['shelf.io.connection_info'] as HttpConnectionInfo?)?.remoteAddress;
    final clientUserAgent = request.headers['User-Agent'];
    final encodedToken = await dbUser.startSession(_identityTokenAuthority, _isar, clientIpAddress, clientUserAgent);
    // dbUser is added to database inside this ^ call so no need to do it in this scope

    return Response.ok('Success', headers: {'token': encodedToken});
  }

  FutureOr<Response> _startSession(Request request) async {
    final uid = request.headers['uid'];
    if (uid == null) return Response.badRequest();
    final password = request.headers['password'];
    if (password == null) return Response.badRequest();

    final dbUser = await _isar.users.getAsync(uid);
    if (dbUser == null) return Response.forbidden('Authentication error');

    if (!await dbUser.password.checkPasswordMatch(password)) return Response.forbidden('Authentication error');

    final clientIpAddress = (request.context['shelf.io.connection_info'] as HttpConnectionInfo?)?.remoteAddress;
    final clientUserAgent = request.headers['User-Agent'];
    final encodedToken = await dbUser.startSession(_identityTokenAuthority, _isar, clientIpAddress, clientUserAgent);

    return Response.ok('Success', headers: {'token': encodedToken});
  }

  FutureOr<Response> _getNameHandler(Request request) async {
    final identityToken = verifyIdentityToken(_identityTokenAuthority, request);
    if (identityToken == null) return Response.forbidden('Authentication error');

    if (identityToken.userId == null) return Response.ok('You are logged in anonymously.');

    final dbUser = await _isar.users.getAsync(identityToken.userId!);
    if (dbUser == null) return Response.forbidden('Authentication error');

    return Response.ok('Your are logged in as ${dbUser.name}');
  }

  bool _validateNewName(String name) {
    // TODO
    return true;
  }

  bool _validateNewEmail(String email) {
    // TODO
    return true;
  }

  bool _validateNewPassword(String password) {
    // TODO
    return true;
  }
}
