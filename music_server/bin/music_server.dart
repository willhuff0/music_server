import 'dart:io';

import 'package:isar/isar.dart';
import 'package:music_server/sync.dart';
import 'package:music_server/transcoding.dart';
import 'package:music_server/music_server.dart';
import 'package:music_server/stateless_server/stateless_server.dart';

void main(List<String> arguments) async {
  StatelessServer? statelessServer;
  Isar? mainIsolateIsar;

  try {
    stdout.writeln('Server starting...');

    final config = MusicServerConfig();
    final paths = MusicServerPaths.fromCurrentOS();
    final privateKey = generateSecureRandomKey(config.tokenKeyLength);

    final workerLaunchArgs = APIWorkerLaunchArgs(
      config: config,
      createThreadData: makeMusicServerCreateThreadData(paths, config, privateKey),
      customHandlers: musicServerCustomHandlers,
      onClose: (threadData) {
        if (threadData is! MusicServerThreadData) return;
        threadData.isar.close();
      },
    );
    statelessServer = await StatelessServer.start(config: config, workerLaunchArgs: workerLaunchArgs);

    mainIsolateIsar = openIsarDatabaseOnIsolate(paths, inspector: forceDebug || !const bool.fromEnvironment("dart.vm.product"));

    startDispatchingTranscodeWorkers(mainIsolateIsar, paths, config);
    startDispatchingSyncSessionWorkers(mainIsolateIsar, paths, config);

    stdout.writeln('Listening on ${config.address.address}:${config.port}');

    await ProcessSignal.sigint.watch().first;
  } finally {
    stdout.writeln('\nShutting down...');

    await statelessServer?.shutdown();
    if (!await Future.any([
      Future.wait([
        shutdownTranscodeWorkers(),
        shutdownSyncSessionWorkers(),
      ]).then((value) => true),
      ProcessSignal.sigint.watch().first.then((value) => false),
    ])) {
      stdout.writeln('\nCancelling transcode operations, will attempt to resume on next start');
      stdout.writeln('Shutdown succeeded with warnings');
      exit(1);
    }
    await mainIsolateIsar?.close();

    stdout.writeln('Shutdown succeeded');
    exit(0);
  }
}
