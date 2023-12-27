import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:cryptography/cryptography.dart';
import 'package:isar/isar.dart';
import 'package:music_server/music_server.dart';
import 'package:music_server/stateless_server/stateless_server.dart';

part 'user.g.dart';

@collection
class User {
  Id isarId;

  @Index(unique: true)
  final String id;

  final String name;

  @Index(unique: true)
  final String email;

  final HashedUserPassword password;

  @enumerated
  final UserTier tier;

  User({
    this.isarId = Isar.autoIncrement,
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.tier,
  });

  static User create({
    required String id,
    required String name,
    required String email,
    required HashedUserPassword password,
  }) =>
      User(
        id: id,
        name: name,
        email: email,
        password: password,
        tier: UserTier.free,
      );

  MusicServerIdentityTokenClaims getIdentityTokenClaims() => MusicServerIdentityTokenClaims(
        tier: tier,
      );

  String startSession(IdentityTokenAuthority<MusicServerIdentityTokenClaims> identityTokenAuthority, InternetAddress? ipAddress, String? userAgent) {
    final identityToken = IdentityToken(id, ipAddress, userAgent, getIdentityTokenClaims());
    final encodedToken = identityTokenAuthority.signAndEncodeToken(identityToken);
    return encodedToken;
  }
}

// TODO: swap for native c library
final _passwordHashingAlgorithm = Argon2id(
  parallelism: 1,
  memory: 19456,
  iterations: 2,
  hashLength: 32,
);

@embedded
class HashedUserPassword {
  final List<byte> nonce;
  final List<byte> hash;

  HashedUserPassword({
    this.nonce = const [],
    this.hash = const [],
  });

  static Future<HashedUserPassword> createNew(String password) async {
    final passwordNonce = generateSecureRandomKey(4);
    final passwordHash = await _passwordHashingAlgorithm.deriveKeyFromPassword(password: password, nonce: passwordNonce).then((value) => value.extractBytes());
    return HashedUserPassword(hash: passwordHash, nonce: passwordNonce);
  }

  Future<bool> checkPasswordMatch(String password) async {
    final passwordHash = await _passwordHashingAlgorithm.deriveKeyFromPassword(password: password, nonce: nonce).then((value) => value.extractBytes());
    return ListEquality().equals(passwordHash, hash);
  }
}

/// Compares two [Uint8List]s by comparing 8 bytes at a time.
bool memEquals(Uint8List bytes1, Uint8List bytes2) {
  if (identical(bytes1, bytes2)) {
    return true;
  }

  if (bytes1.lengthInBytes != bytes2.lengthInBytes) {
    return false;
  }

  // Treat the original byte lists as lists of 8-byte words.
  var numWords = bytes1.lengthInBytes ~/ 8;
  var words1 = bytes1.buffer.asUint64List(0, numWords);
  var words2 = bytes2.buffer.asUint64List(0, numWords);

  for (var i = 0; i < words1.length; i += 1) {
    if (words1[i] != words2[i]) {
      return false;
    }
  }

  // Compare any remaining bytes.
  for (var i = words1.lengthInBytes; i < bytes1.lengthInBytes; i += 1) {
    if (bytes1[i] != bytes2[i]) {
      return false;
    }
  }

  return true;
}

enum UserTier {
  free,
  paid,
}
