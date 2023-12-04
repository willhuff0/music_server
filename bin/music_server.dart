import 'package:music_server/database.dart';
import 'package:music_server/workers.dart';
import 'package:stateless_server/stateless_server.dart';

void main(List<String> arguments) async {
  final config = ServerConfig();
  final workerLaunchArgs = WorkerLaunchArgsWithAuthentication(
    start: MusicAuthenticationWorker.start,
    config: config,
    privateKey: generateSecureRandomKey(config.tokenKeyLength),
  );
  await StatelessServer.start(config: config, workerLaunchArgs: workerLaunchArgs);

  final database = await openIsarDatabaseOnIsolate(inspector: true);
}
