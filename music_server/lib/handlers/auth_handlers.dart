import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:isar/isar.dart';
import 'package:music_server/database/user.dart';
import 'package:music_server/database/user_activity.dart';
import 'package:music_server/music_server.dart';
import 'package:music_server/phonetics.dart';
import 'package:music_server/stateless_server/stateless_server.dart';
import 'package:music_shared/music_shared.dart';
import 'package:uuid/data.dart';
import 'package:uuid/rng.dart';
import 'package:uuid/uuid.dart';

final _secureUuid = Uuid(goptions: GlobalOptions(CryptoRNG()));

FutureOr<Response> authCreateUserHandler(Request request, MusicServerThreadData threadData) async {
  final name = request.headers['name'];
  if (name == null) return Response.badRequest();
  if (!validateUserName(name)) return Response.badRequest();

  final email = request.headers['email'];
  if (email == null) return Response.badRequest();
  if (!validateUserEmail(email)) return Response.badRequest();

  final password = request.headers['password'];
  if (password == null) return Response.badRequest();
  if (!validateUserPassword(password)) return Response.badRequest();

  final hashedUserPassword = await HashedUserPassword.createNew(password);

  final userId = _secureUuid.v7();

  final dbUser = User.create(
    id: userId,
    name: name,
    email: email,
    password: hashedUserPassword,
  );

  try {
    threadData.isar.writeTxnSync(() {
      threadData.isar.users.putSync(dbUser);
      threadData.isar.userActivities.putSync(UserActivity.now(userId, UserActivityType.createUserAndStartSession));
    });
  } catch (e) {
    if (e is IsarUniqueViolationError) {
      return Response.forbidden(''); // TODO: email verification
    } else {
      return Response.internalServerError();
    }
  }

  final clientIpAddress = (request.context['shelf.io.connection_info'] as HttpConnectionInfo?)?.remoteAddress;
  final clientUserAgent = request.headers['User-Agent'];
  final encodedToken = dbUser.startSession(threadData.identityTokenAuthority, clientIpAddress, clientUserAgent);

  return Response.ok('', headers: {'token': encodedToken});
}

FutureOr<Response> authStartSessionHandler(Request request, MusicServerThreadData threadData) async {
  var uid = request.headers['uid'];
  final email = request.headers['email'];
  if (uid == null) {
    if (email == null) return Response.badRequest();

    final userFromEmail = threadData.isar.users.where().emailEqualTo(email).findFirstSync();
    if (userFromEmail == null) return Response.notFound('');
    uid = userFromEmail.id;
  }

  final password = request.headers['password'];
  if (password == null) return Response.badRequest();

  final dbUser = threadData.isar.users.getByIdSync(uid);
  if (dbUser == null) return Response.notFound('');

  if (!await dbUser.password.checkPasswordMatch(password)) return Response.forbidden('');

  final clientIpAddress = (request.context['shelf.io.connection_info'] as HttpConnectionInfo?)?.remoteAddress;
  final clientUserAgent = request.headers['User-Agent'];
  final encodedToken = dbUser.startSession(threadData.identityTokenAuthority, clientIpAddress, clientUserAgent);

  threadData.isar.writeTxnSync(() => threadData.isar.userActivities.putSync(UserActivity.now(uid!, UserActivityType.startSession)));

  return Response.ok('', headers: {'token': encodedToken});
}

FutureOr<Response> authGetNameHandler(Request request, MusicServerThreadData threadData, IdentityToken identityToken) async {
  if (identityToken.userId == null) return Response.ok('Anonymous');

  final dbUser = threadData.isar.users.getByIdSync(identityToken.userId!);
  if (dbUser == null) return Response.forbidden('');

  return Response.ok(dbUser.name);
}

FutureOr<Response> authSearchUserHandler(Request request, MusicServerThreadData threadData, IdentityToken identityToken) {
  final queryString = request.headers['query'];
  if (queryString == null || queryString.isEmpty || queryString.length > userNameMaxLength) return Response.badRequest();

  int start;
  final startString = request.headers['start'];
  if (startString != null) {
    final startInt = int.tryParse(startString);
    if (startInt == null || startInt < 0) return Response.badRequest();
    start = startInt;
  } else {
    start = 0;
  }

  int limit;
  final limitString = request.headers['limit'];
  if (limitString != null) {
    final limitInt = int.tryParse(limitString);
    if (limitInt == null || limitInt < 0 || limitInt > 10) return Response.badRequest();
    limit = limitInt;
  } else {
    limit = 10;
  }

  final queryPhonetics = getPhoneticCodesOfQuery(queryString);
  final searchResults = threadData.isar.users.where().anyOf(queryPhonetics, (q, element) => q.namePhoneticsElementEqualTo(element)).offset(start).limit(limit).findAllSync();

  return Response.ok(jsonEncode(searchResults.map((user) => user.toJson()).toList()));
}
