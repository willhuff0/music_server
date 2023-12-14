import 'dart:io';

import 'package:isar/isar.dart';
import 'package:music_server/database/song.dart';
import 'package:music_server/database/transcode_operation.dart';
import 'package:music_server/database/unprocessed_song.dart';
import 'package:music_server/database/user_activity.dart';
import 'package:music_server/handlers/auth_handlers.dart';
import 'package:music_server/handlers/song_handlers.dart';
import 'package:music_server/stateless_server/stateless_server.dart';
import 'package:path/path.dart' as p;

import 'database/user.dart';

class MusicServerConfig extends ServerConfig {
  /// The number of workers spawned to serve requests
  final int numTranscodeWorkers;

  MusicServerConfig({
    super.numWorkers,
    super.address,
    super.port,
    super.tokenLifetime,
    super.tokenHashAlg,
    super.tokenKeyLength,
    this.numTranscodeWorkers = 2,
    super.tokenClaimsFromJson = MusicServerIdentityTokenClaims.fromJson,
  });
}

class MusicServerThreadData extends CustomThreadDataWithAuth<MusicServerIdentityTokenClaims> {
  final MusicServerPaths paths;
  final Isar isar;

  MusicServerThreadData({
    required super.identityTokenAuthority,
    required this.paths,
    required this.isar,
  });
}

class MusicServerIdentityTokenClaims extends IdentityTokenClaims {
  final UserTier tier;

  MusicServerIdentityTokenClaims({
    required this.tier,
  });

  static MusicServerIdentityTokenClaims fromJson(Map<String, dynamic> json) {
    //final tier = UserTier.values[json['tier'] as int? ?? 0];

    UserTier tier;
    final tierInt = json['tier'] as int?;
    if (tierInt != null) {
      tier = UserTier.values[tierInt];
    } else {
      tier = UserTier.free;
    }

    return MusicServerIdentityTokenClaims(
      tier: tier,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        if (tier != UserTier.free) 'tier': tier.index,
      };

  bool canSongCreate() => tier == UserTier.paid;
  bool canSongGetData() => tier == UserTier.paid;
}

class MusicServerPaths {
  late final String rootPath;
  late final String databasePath;
  late final String storagePath;

  late final String ffmpegPath;
  late final String ffprobePath;

  MusicServerPaths.fromCurrentOS() {
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

    ffmpegPath = p.join(rootPath, 'tools', Platform.isWindows ? 'ffmpeg.exe' : 'ffmpeg');
    ffprobePath = p.join(rootPath, 'tools', Platform.isWindows ? 'ffprobe.exe' : 'ffprobe');

    Directory(databasePath).createSync(recursive: true);
    Directory(storagePath).createSync(recursive: true);
  }
}

MusicServerThreadData Function() makeMusicServerCreateThreadData(MusicServerPaths paths, MusicServerConfig config, List<int> privateKey) => () {
      final identityTokenAuthority = IdentityTokenAuthority<MusicServerIdentityTokenClaims>.initializeOnIsolate(config, privateKey);
      final isar = openIsarDatabaseOnIsolate(paths);

      return MusicServerThreadData(
        identityTokenAuthority: identityTokenAuthority,
        paths: paths,
        isar: isar,
      );
    };

Isar openIsarDatabaseOnIsolate(MusicServerPaths paths, {bool inspector = false}) => Isar.openSync(
      [
        UserSchema,
        UserActivitySchema,
        SongSchema,
        UnprocessedSongSchema,
        TranscodeOperationSchema,
      ],
      directory: paths.databasePath,
      inspector: inspector,
    );

final musicServerCustomHandlers = [
  CustomHandler(path: '/status', handle: statusHandler),

  // Auth
  CustomHandler(path: '/auth/createUser', handle: createUserHandler),
  CustomHandler(path: '/auth/startSession', handle: startSessionHandler),
  CustomHandlerAuthRequired(path: '/auth/getName', handle: getNameHandler),

  // Song
  CustomHandlerAuthRequired(path: '/song/create', handle: songCreateHandler),
  CustomHandlerAuthRequired(path: '/song/uploadData', handle: songUploadDataHandler),
  CustomHandlerAuthRequired(path: '/song/getData', handle: songGetDataHandler),
  CustomHandlerAuthRequired(path: '/song/search', handle: songSearchHandler),
];

Response statusHandler(Request request, MusicServerThreadData threadData) {
  return Response.ok('Operational');
}
