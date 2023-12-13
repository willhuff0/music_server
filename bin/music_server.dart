import 'package:isar/isar.dart';
import 'package:music_server/audio_processing.dart';
import 'package:music_server/music_server.dart';
import 'package:stateless_server/stateless_server.dart';

void main(List<String> arguments) async {
  Isar? inspectorIsar;

  try {
    final config = MusicServerConfig();
    final paths = MusicServerPaths.fromCurrentOS();
    final privateKey = generateSecureRandomKey(config.tokenKeyLength);

    final workerLaunchArgs = CustomWorkerLaunchArgs(
      config: config,
      createThreadData: makeMusicServerCreateThreadData(paths, config, privateKey),
      customHandlers: musicServerCustomHandlers,
      onClose: (threadData) {
        if (threadData is! MusicServerThreadData) return;
        threadData.isar.close();
      },
    );
    await StatelessServer.start(config: config, workerLaunchArgs: workerLaunchArgs);

    startDispatchingTranscodeWorkers(paths, config);

    inspectorIsar = openIsarDatabaseOnIsolate(paths, inspector: true);
  } finally {
    inspectorIsar?.close();
  }
}
