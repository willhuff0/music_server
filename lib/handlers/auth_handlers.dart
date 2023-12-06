import 'dart:async';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:music_server/database/user.dart';
import 'package:music_server/music_server.dart';
import 'package:stateless_server/stateless_server.dart';
import 'package:uuid/data.dart';
import 'package:uuid/rng.dart';
import 'package:uuid/uuid.dart';

final _secureUuid = Uuid(goptions: GlobalOptions(CryptoRNG()));

FutureOr<Response> createUserHandler(Request request, MusicServerThreadData threadData) async {
  final name = request.headers['name'];
  if (name == null) return Response.badRequest();
  if (!_validateNewUserName(name)) return Response.badRequest();

  final email = request.headers['email'];
  if (email == null) return Response.badRequest();
  if (!_validateNewUserEmail(email)) return Response.badRequest();

  final password = request.headers['password'];
  if (password == null) return Response.badRequest();
  if (!_validateNewUserPassword(password)) return Response.badRequest();

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
  final encodedToken = await dbUser.startSession(threadData, clientIpAddress, clientUserAgent);
  // dbUser is added to database inside this ^ call so no need to do it in this scope

  return Response.ok('Success', headers: {'token': encodedToken});
}

bool _validateNewUserName(String name) {
  const minLength = 2;
  const maxLength = 24;

  if (name.length < minLength || name.length > maxLength) return false;

  return true;
}

bool _validateNewUserEmail(String email) {
  return EmailValidator.validate(email);
}

bool _validateNewUserPassword(String password) {
  const minLength = 8;
  const maxLength = 64;

  if (password.length < minLength || password.length > maxLength) return false;

  return true;
}

FutureOr<Response> startSessionHandler(Request request, MusicServerThreadData threadData) async {
  final uid = request.headers['uid'];
  if (uid == null) return Response.badRequest();
  final password = request.headers['password'];
  if (password == null) return Response.badRequest();

  final dbUser = threadData.isar.users.get(uid);
  if (dbUser == null) return Response.forbidden('Authentication error');

  if (!await dbUser.password.checkPasswordMatch(password)) return Response.forbidden('Authentication error');

  final clientIpAddress = (request.context['shelf.io.connection_info'] as HttpConnectionInfo?)?.remoteAddress;
  final clientUserAgent = request.headers['User-Agent'];
  final encodedToken = await dbUser.startSession(threadData, clientIpAddress, clientUserAgent);

  return Response.ok('Success', headers: {'token': encodedToken});
}

FutureOr<Response> getNameHandler(Request request, MusicServerThreadData threadData, IdentityToken identityToken) async {
  if (identityToken.userId == null) return Response.ok('You are logged in anonymously.');

  final dbUser = threadData.isar.users.get(identityToken.userId!);
  if (dbUser == null) return Response.forbidden('Authentication error');

  return Response.ok('Your are logged in as ${dbUser.name}');
}
