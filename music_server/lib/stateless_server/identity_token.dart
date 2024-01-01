import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:music_server/stateless_server/server.dart';
import 'package:music_shared/music_shared.dart';

final Random _random = Random.secure();
Uint8List generateSecureRandomKey(int bytes) => _random.nextBytes(bytes);

class IdentityTokenAuthority<TClaims extends IdentityTokenClaims> {
  final ServerConfig _config;
  final Hmac _hmac;

  IdentityTokenAuthority.initializeOnIsolate(this._config, List<int> privateKey) : _hmac = Hmac(_config.tokenHashAlg, privateKey);

  IdentityToken<TClaims>? verifyAndDecodeToken(String encodedToken) {
    try {
      List<String> encodedParts = encodedToken.split('.');
      if (encodedParts.length != 2) return null;

      Uint8List body = base64.decode(encodedParts[0]);
      Map<String, dynamic> bodyMap = jsonDecode(utf8.decode(body));

      // Verify timestamp
      final timestampString = bodyMap['time'] as String?;
      if (timestampString == null) return null;
      final timestamp = DateTime.tryParse(timestampString);
      if (timestamp == null) return null;
      if (DateTime.now().toUtc().difference(timestamp) > tokenLifetime) return null;

      // Verify signature
      Digest claimedSignature = Digest(base64.decode(encodedParts[1]));
      Digest actualSignature = _hmac.convert(body);
      if (claimedSignature != actualSignature) return null;

      InternetAddress? ip;
      final ipString = bodyMap['ip'] as String?;
      if (ipString != null) {
        ip = InternetAddress.tryParse(ipString);
      }

      IdentityToken<TClaims> token = IdentityToken<TClaims>._(
        userId: bodyMap['uid'] as String?,
        displayName: bodyMap['name'] as String?,
        timestamp: timestamp,
        ipAddress: ip,
        userAgent: bodyMap['agent'] as String?,
        claims: _config.tokenClaimsFromJson(bodyMap['claims'] as Map<String, dynamic>? ?? {}) as TClaims,
      );

      return token;
    } catch (e) {
      print('Failed to verify token: $e');
      return null;
    }
  }

  String signAndEncodeToken(IdentityToken token) {
    final claimsJson = token.claims.toJson();

    Map<String, dynamic> bodyMap = {
      if (token.userId != null) 'uid': token.userId,
      if (token.displayName != null) 'name': token.displayName,
      'time': token.timestamp.toIso8601String(),
      if (token.ipAddress != null) 'ip': token.ipAddress!.address,
      if (token.userAgent != null) 'agent': token.userAgent,
      'key': generateSecureRandomKey(_config.tokenKeyLength),
      if (claimsJson.isNotEmpty) 'claims': claimsJson,
    };

    Uint8List body = utf8.encode(jsonEncode(bodyMap));
    List<int> signature = _hmac.convert(body).bytes;

    String encodedBody = base64.encode(body);
    String encodedSignature = base64.encode(signature);
    return '$encodedBody.$encodedSignature';
  }
}

class IdentityToken<TClaims extends IdentityTokenClaims> {
  final String? userId;
  final String? displayName;
  final DateTime timestamp;
  final InternetAddress? ipAddress;
  final String? userAgent;
  final TClaims claims;

  IdentityToken._({
    required this.userId,
    required this.displayName,
    required this.timestamp,
    required this.ipAddress,
    required this.userAgent,
    required this.claims,
  });

  IdentityToken(this.userId, this.displayName, this.ipAddress, this.userAgent, this.claims) : timestamp = DateTime.now().toUtc();
}

class IdentityTokenClaims {
  static IdentityTokenClaims fromJson(Map<String, dynamic> json) => IdentityTokenClaims();

  Map<String, dynamic> toJson() => {};
}

extension RandomExtensions on Random {
  int nextByte() => nextInt(255);

  Uint8List nextBytes(int length) {
    final result = Uint8List(length);
    for (var i = 0; i < length; i++) {
      result[i] = nextByte();
    }
    return result;
  }
}
