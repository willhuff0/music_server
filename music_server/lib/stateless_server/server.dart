import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:music_server/stateless_server/identity_token.dart';
import 'package:music_server/stateless_server/worker.dart';

class StatelessServer {
  final ServerConfig config;
  final WorkerLaunchArgs workerLaunchArgs;

  final List<WorkerManager> _workerManagers;

  StatelessServer._(this.config, this.workerLaunchArgs, this._workerManagers);

  static Future<StatelessServer> start({required ServerConfig config, required WorkerLaunchArgs workerLaunchArgs}) async {
    final workerManagers = await Future.wait(Iterable.generate(config.numWorkers, (index) => WorkerManager.start(workerLaunchArgs, debugName: 'Worker $index')));
    return StatelessServer._(config, workerLaunchArgs, workerManagers);
  }

  Future<void> shutdown() async {
    await Future.wait(_workerManagers.map((e) => e.shutdown()));
  }
}

class ServerConfig {
  /// The number of workers spawned to serve requests
  final int numWorkers;

  /// The IP to bind workers to
  final InternetAddress address;

  /// The Port to bind workers to
  final int port;

  /// The hashing algorithm used to sign identity tokens
  final Hash tokenHashAlg;

  /// The length in bytes of the random keys generated for identity tokens
  final int tokenKeyLength;

  /// Usually a constructor or static method that decodes a class implementing IdentityTokenClaims
  final IdentityTokenClaims Function(Map<String, dynamic> json) tokenClaimsFromJson;

  ServerConfig({
    this.numWorkers = 8,
    InternetAddress? address,
    this.port = 8081,
    this.tokenHashAlg = sha256,
    this.tokenKeyLength = 256 ~/ 8,
    this.tokenClaimsFromJson = IdentityTokenClaims.fromJson,
  }) : address = address ?? InternetAddress.anyIPv4;
}
