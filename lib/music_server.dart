import 'package:isar/isar.dart';
import 'package:music_server/handlers/auth.dart';
import 'package:stateless_server/stateless_server.dart';

import 'database.dart';

class MusicServerThreadData extends CustomThreadDataWithAuth {
  final Isar isar;

  MusicServerThreadData({
    required super.identityTokenAuthority,
    required this.isar,
  });
}

Future<MusicServerThreadData> Function() makeMusicServerCreateThreadData(ServerConfig config, List<int> privateKey) => () async {
      final identityTokenAuthority = IdentityTokenAuthority.initializeOnIsolate(config, privateKey);
      final isar = await openIsarDatabaseOnIsolate();

      return MusicServerThreadData(
        identityTokenAuthority: identityTokenAuthority,
        isar: isar,
      );
    };

final musicServerCustomHandlers = [
  CustomHandler(path: '/status', handle: statusHandler),
  CustomHandler(path: '/auth/createUser', handle: createUserHandler),
  CustomHandler(path: '/auth/startSession', handle: startSessionHandler),
  CustomHandlerAuthRequired(path: '/auth/getName', handle: getNameHandler),
];

Response statusHandler(Request request, MusicServerThreadData threadData) {
  return Response.ok('Operational');
}
