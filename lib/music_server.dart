import 'dart:io';

import 'package:isar/isar.dart';
import 'package:music_server/database/song.dart';
import 'package:music_server/database/transcode_operation.dart';
import 'package:music_server/handlers/auth_handlers.dart';
import 'package:stateless_server/stateless_server.dart';
import 'package:path/path.dart' as p;

import 'database/user.dart';

late final String rootPath;
late final String databasePath;
late final String storagePath;

void setupServerEnvironment() {
  String root;
  if (const bool.fromEnvironment("dart.vm.product")) {
    root = p.dirname(Platform.resolvedExecutable);
  } else {
    root = Directory.current.path;
  }

  root = p.join(root, 'server_root');

  rootPath = root;
  databasePath = p.join(rootPath, 'database');
  storagePath = p.join(rootPath, 'storage');

  Directory(databasePath).createSync(recursive: true);
  Directory(storagePath).createSync(recursive: true);
}

Isar openIsarDatabaseOnIsolate({bool inspector = false}) => Isar.open(
      schemas: [
        UserSchema,
        UserActivitySchema,
        SongSchema,
        UnprocessedSongSchema,
        TranscodeOperationSchema,
      ],
      directory: databasePath,
      inspector: inspector,
    );

class MusicServerThreadData extends CustomThreadDataWithAuth {
  final Isar isar;

  MusicServerThreadData({
    required super.identityTokenAuthority,
    required this.isar,
  });
}

MusicServerThreadData Function() makeMusicServerCreateThreadData(ServerConfig config, List<int> privateKey) => () {
      final identityTokenAuthority = IdentityTokenAuthority.initializeOnIsolate(config, privateKey);
      final isar = openIsarDatabaseOnIsolate();

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
