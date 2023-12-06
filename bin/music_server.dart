import 'package:music_server/music_server.dart';
import 'package:stateless_server/stateless_server.dart';

void main(List<String> arguments) async {
  final config = ServerConfig();
  final privateKey = generateSecureRandomKey(config.tokenKeyLength);

  final workerLaunchArgs = CustomWorkerLaunchArgs(
    config: config,
    createThreadData: makeMusicServerCreateThreadData(config, privateKey),
    customHandlers: musicServerCustomHandlers,
  );
  await StatelessServer.start(config: config, workerLaunchArgs: workerLaunchArgs);

  openIsarDatabaseOnIsolate(inspector: true);
}
