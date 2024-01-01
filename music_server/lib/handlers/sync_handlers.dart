import 'dart:async';
import 'dart:io';

import 'package:music_server/database/sync_session.dart';
import 'package:music_server/music_server.dart';
import 'package:music_server/stateless_server/stateless_server.dart';

FutureOr<Response> syncStartOrJoinSessionHandler(Request request, MusicServerThreadData threadData, IdentityToken<MusicServerIdentityTokenClaims> identityToken) async {
  final userId = identityToken.userId;
  if (userId == null) return Response.unauthorized('');
  if (!identityToken.claims.canSongCreate()) return Response.unauthorized('');

  final ip = (request.context['shelf.io.connection_info'] as HttpConnectionInfo?)?.remoteAddress.address;
  if (ip == null) return Response.badRequest();

  var syncSession = threadData.isar.syncSessions.getByUserIdSync(userId);
  if (syncSession != null) {
    syncSession.authorizedClients = {...syncSession.authorizedClients, ip}.toList();
    threadData.isar.writeTxnSync(() => threadData.isar.syncSessions.putSync(syncSession!));

    int? port;
    if (syncSession.port != null) {
      port = syncSession.port!;
    } else {
      final completer = Completer<int?>();

      final subscription = threadData.isar.syncSessions.watchObject(syncSession.isarId).listen((newSyncSession) {
        if (newSyncSession != null && newSyncSession.port != null) {
          completer.complete(newSyncSession.port);
        }
      });

      port = await completer.future.timeout(Duration(seconds: 10), onTimeout: () => null);
      await subscription.cancel();
    }

    if (port != null) {
      return Response.ok(port.toString());
    } else {
      return Response.internalServerError();
    }
  } else {
    // Start new session

    syncSession = SyncSession(
      userId: userId,
      authorizedClients: [ip],
    );

    final completer = Completer<SyncSession?>();

    threadData.isar.writeTxnSync(() => threadData.isar.syncSessions.putSync(syncSession!));
    final subscription = threadData.isar.syncSessions.watchObject(syncSession.isarId).listen((newSyncSession) {
      if (newSyncSession != null && newSyncSession.port != null) {
        completer.complete(newSyncSession);
      }
    });

    threadData.isar.writeTxnSync(() => threadData.isar.syncSessions.putSync(syncSession!));
    final newSyncSession = await completer.future.timeout(Duration(seconds: 10), onTimeout: () => null);
    await subscription.cancel();

    if (newSyncSession != null && newSyncSession.port != null) {
      return Response.ok(newSyncSession.port.toString());
    } else {
      return Response.internalServerError();
    }
  }
}
