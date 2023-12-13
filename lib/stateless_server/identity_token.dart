import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:music_server/stateless_server/server.dart';

final Random _random = Random.secure();
Uint8List generateSecureRandomKey(int bytes) => _random.nextBytes(bytes);

class IdentityTokenAuthority {
  final ServerConfig _config;
  final Hmac _hmac;

  IdentityTokenAuthority.initializeOnIsolate(this._config, List<int> privateKey) : _hmac = Hmac(_config.tokenHashAlg, privateKey);

  IdentityToken? verifyAndDecodeToken(String encodedToken) {
    try {
      List<String> encodedParts = encodedToken.split('.');
      if (encodedParts.length != 2) return null;

      Uint8List body = base64.decode(encodedParts[0]);
      Map<String, dynamic> bodyMap = jsonDecode(utf8.decode(body));

      final timestampString = bodyMap['time'] as String?;
      if (timestampString == null) return null;
      final timestamp = DateTime.tryParse(timestampString);
      if (timestamp == null) return null;

      IdentityToken token = IdentityToken._(
        userId: bodyMap['uid'] as String?,
        timestamp: timestamp,
        ipAddress: bodyMap.containsKey('ip') ? InternetAddress.tryParse(bodyMap['ip'] as String) : null,
        userAgent: bodyMap['agent'] as String?,
      );

      if (DateTime.now().toUtc().difference(token.timestamp) > _config.tokenLifetime) return null;

      Digest claimedSignature = Digest(base64.decode(encodedParts[1]));
      Digest actualSignature = _hmac.convert(body);

      if (claimedSignature != actualSignature) return null;

      return token;
    } catch (e) {
      print('Failed to verify token: $e');
      return null;
    }
  }

  String signAndEncodeToken(IdentityToken token) {
    Map<String, dynamic> bodyMap = {
      if (token.userId != null) 'uid': token.userId,
      'time': token.timestamp.toIso8601String(),
      if (token.ipAddress != null) 'ip': token.ipAddress!.address,
      if (token.userAgent != null) 'agent': token.userAgent,
      'key': generateSecureRandomKey(_config.tokenKeyLength),
    };

    Uint8List body = utf8.encode(jsonEncode(bodyMap));
    List<int> signature = _hmac.convert(body).bytes;

    String encodedBody = base64.encode(body);
    String encodedSignature = base64.encode(signature);
    return '$encodedBody.$encodedSignature';
  }
}

class IdentityToken {
  final String? userId;
  final DateTime timestamp;
  final InternetAddress? ipAddress;
  final String? userAgent;

  IdentityToken._({required this.userId, required this.timestamp, required this.ipAddress, required this.userAgent});

  IdentityToken(this.userId, this.ipAddress, this.userAgent) : timestamp = DateTime.now().toUtc();
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
