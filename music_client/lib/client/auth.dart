import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:music_client/client/client.dart';
import 'package:music_shared/music_shared.dart';

const secureStorage = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));

Future<void>? _currentTokenWriteOperation;

String? _identityToken;
String? get identityToken => _identityToken;
set identityToken(String? value) {
  _identityToken = value;
  _currentTokenWriteOperation = _currentTokenWriteOperation?.then((_) => secureStorage.write(key: 'token', value: value)) ?? secureStorage.write(key: 'token', value: value);
  _authStateChangedController.add(value);
}

final StreamController<String?> _authStateChangedController = StreamController.broadcast();
final authStateChanged = _authStateChangedController.stream;

class IdentityToken {
  final String? userId;
  final DateTime timestamp;
  final InternetAddress? ipAddress;
  final String? userAgent;
  final Map<String, dynamic> claims;

  IdentityToken._({required this.userId, required this.timestamp, required this.ipAddress, required this.userAgent, required this.claims});

  static IdentityToken? decode(String encodedToken) {
    List<String> encodedParts = encodedToken.split('.');
    if (encodedParts.length != 2) return null;

    Uint8List body = base64.decode(encodedParts[0]);
    Map<String, dynamic> bodyMap = jsonDecode(utf8.decode(body));

    final timestampString = bodyMap['time'] as String?;
    if (timestampString == null) return null;
    final timestamp = DateTime.tryParse(timestampString);
    if (timestamp == null) return null;
    if (DateTime.now().toUtc().difference(timestamp) > tokenLifetime) return null;

    InternetAddress? ip;
    final ipString = bodyMap['ip'] as String?;
    if (ipString != null) {
      ip = InternetAddress.tryParse(ipString);
    }

    return IdentityToken._(
      userId: bodyMap['uid'] as String?,
      timestamp: timestamp,
      ipAddress: ip,
      userAgent: bodyMap['agent'] as String?,
      claims: bodyMap['claims'] as Map<String, dynamic>? ?? {},
    );
  }
}

Future<(bool success, List<String> errors)> createUser(String name, String email, String password) async {
  final errors = <String>[];
  if (!validateUserName(name)) errors.add('name');
  if (!validateUserEmail(email)) errors.add('email');
  if (!validateUserPassword(password)) errors.add('password');
  if (errors.isNotEmpty) return (false, errors);

  final response = await apiCall('/auth/createUser', headers: {
    'name': name,
    'email': email,
    'password': password,
  });
  if (response.statusCode != 200) return (false, ['server_other', response.statusCode.toString()]);

  final identityTokenString = response.headers['token'];
  if (identityTokenString == null) return (false, ['server_token']);

  final identityTokenObject = IdentityToken.decode(identityTokenString);
  if (identityTokenObject == null) return (false, ['server_token']);

  identityToken = identityTokenString;
  await secureStorage.write(key: 'uid', value: identityTokenObject.userId);
  await secureStorage.write(key: 'password', value: password);

  return (true, <String>[]);
}

Future<int> startSession({String? uid, String? email, required String password}) async {
  assert(uid != null && email == null || uid == null && email != null);

  final response = await apiCall('/auth/startSession', headers: {
    if (uid != null) 'uid': uid,
    if (email != null) 'email': email,
    'password': password,
  });
  if (response.statusCode != 200) return response.statusCode;
  identityToken = response.headers['token'];
  return 200;
}

Future<bool> startSessionWithSavedCredentials() async {
  final uidString = await secureStorage.read(key: 'uid');
  if (uidString == null || uidString.isEmpty) return false;

  final passwordString = await secureStorage.read(key: 'password');
  if (passwordString == null || passwordString.isEmpty) return false;

  return await startSession(uid: uidString, password: passwordString) == 200;
}

void signOut() {
  identityToken = null;
  secureStorage.delete(key: 'uid');
  secureStorage.delete(key: 'password');
}

/// Auth required
Future<String?> getName() async {
  if (identityToken == null) return null;
  final response = await apiCallAuthRequired('/auth/getName', headers: {
    'token': identityToken!,
  });
  if (response.statusCode == 200) {
    return response.bodyString;
  } else {
    return null;
  }
}
