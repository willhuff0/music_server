import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:cryptography/cryptography.dart';
import 'package:isar/isar.dart';
import 'package:music_server/music_server.dart';
import 'package:music_server/phonetics.dart';
import 'package:music_server/stateless_server/stateless_server.dart';
import 'package:music_shared/music_shared.dart';

part 'user.g.dart';

@collection
class User {
  Id isarId;

  @Index(unique: true)
  final String id;

  final String name;

  final Set<String> _namePhonetics;
  @Index(type: IndexType.value, caseSensitive: false)
  List<String> get namePhonetics => _namePhonetics.toList();

  @Index(unique: true)
  final String email;

  final HashedUserPassword password;

  @enumerated
  final UserTier tier;

  final Set<GenreFavor> _favors;
  List<GenreFavor> get favors => _favors.toList();
  final DateTime lastFavorCheck;

  User({
    this.isarId = Isar.autoIncrement,
    required this.id,
    required this.name,
    required List<String> namePhonetics,
    required this.email,
    required this.password,
    required this.tier,
    required List<GenreFavor> favors,
    required this.lastFavorCheck,
  })  : _namePhonetics = namePhonetics.toSet(),
        _favors = favors.toSet();

  User.create({required this.id, required this.name, required this.email, required this.password})
      : isarId = Isar.autoIncrement,
        _namePhonetics = getPhoneticCodesOfQuery(name),
        tier = UserTier.paid,
        _favors = {},
        lastFavorCheck = DateTime.timestamp();

  MusicServerIdentityTokenClaims getIdentityTokenClaims() => MusicServerIdentityTokenClaims(
        tier: tier,
      );

  String startSession(IdentityTokenAuthority<MusicServerIdentityTokenClaims> identityTokenAuthority, InternetAddress? ipAddress, String? userAgent) {
    final identityToken = IdentityToken(id, name, ipAddress, userAgent, getIdentityTokenClaims());
    final encodedToken = identityTokenAuthority.signAndEncodeToken(identityToken);
    return encodedToken;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  List<GenreFavor> getTopGenres(int count) => _favors.sorted((a, b) => b.favor.compareTo(a.favor)).take(count).toList();
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

@embedded
class GenreFavor {
  @enumerated
  final Genre genre;
  double favor;

  GenreFavor({this.genre = Genre.pop, this.favor = 1.0});

  @override
  bool operator ==(Object other) {
    if (other is GenreFavor) {
      return genre == other.genre;
    }
    return false;
  }

  int? _hashCode;
  @override
  int get hashCode {
    _hashCode ??= genre.hashCode;
    return _hashCode!;
  }
}
