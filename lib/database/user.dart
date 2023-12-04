import 'package:cryptography/cryptography.dart';
import 'package:isar/isar.dart';
import 'package:stateless_server/stateless_server.dart';

part 'user.g.dart';

@collection
class User {
  final String id;

  final String name;
  final String email;

  final HashedUserPassword password;

  final List<UserActivity> activity;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.activity = const [],
  });
}

final _passwordHashingAlgorithm = Argon2id(
  parallelism: 1,
  memory: 19456,
  iterations: 2,
  hashLength: 32,
);

@embedded
class HashedUserPassword {
  final List<int> nonce;
  final List<int> hash;

  HashedUserPassword({
    required this.nonce,
    required this.hash,
  });

  static Future<HashedUserPassword> createNew(String password) async {
    final passwordNonce = generateSecureRandomKey(4);
    final passwordHash = await _passwordHashingAlgorithm.deriveKeyFromPassword(password: password, nonce: passwordNonce).then((value) => value.extractBytes());
    return HashedUserPassword(hash: passwordHash, nonce: passwordNonce);
  }

  Future<bool> checkPasswordMatch(String password) async {
    final passwordHash = await _passwordHashingAlgorithm.deriveKeyFromPassword(password: password, nonce: nonce).then((value) => value.extractBytes());
    return passwordHash == hash;
  }
}

@embedded
class UserActivity {
  final UserActivityType type;
  final DateTime timestamp;

  UserActivity({
    required this.type,
    required this.timestamp,
  });
}

enum UserActivityType {
  createUser,
  startSession,
}
