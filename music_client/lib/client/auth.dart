import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:music_client/client/client.dart';
import 'package:music_shared/music_shared.dart';
import 'package:synchronized/synchronized.dart';

const _secureStorage = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
final secureStorageLock = Lock();

Future<void> secureStorageWrite({required String key, required String? value}) async {
  await secureStorageLock.synchronized(() async {
    await _secureStorage.write(key: key, value: value);
  });
}

Future<void> secureStorageDelete({required String key}) async {
  await secureStorageLock.synchronized(() async {
    await _secureStorage.delete(key: key);
  });
}

Future<String?> secureStorageRead({required String key}) => _secureStorage.read(key: key);

Future<void>? _currentTokenWriteOperation;

String? _identityToken;
String? get identityToken => _identityToken;
set identityToken(String? value) {
  _identityToken = value;
  if (value != null) {
    _identityTokenObject = IdentityToken.decode(value);
  } else {
    _identityTokenObject = null;
  }
  _currentTokenWriteOperation = _currentTokenWriteOperation?.then((_) => secureStorageWrite(key: 'token', value: value)) ?? secureStorageWrite(key: 'token', value: value);
  _authStateChangedController.add(value);
}

IdentityToken? _identityTokenObject;
IdentityToken? get identityTokenObject => _identityTokenObject;

final StreamController<String?> _authStateChangedController = StreamController.broadcast();
final authStateChanged = _authStateChangedController.stream;

class IdentityToken {
  final String? userId;
  final String? displayName;
  final DateTime timestamp;
  final String? userAgent;
  final Map<String, dynamic> claims;

  IdentityToken._({required this.userId, required this.displayName, required this.timestamp, required this.userAgent, required this.claims});

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

    return IdentityToken._(
      userId: bodyMap['uid'] as String?,
      displayName: bodyMap['name'] as String?,
      timestamp: timestamp,
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
  await secureStorageWrite(key: 'uid', value: identityTokenObject.userId);
  await secureStorageWrite(key: 'password', value: password);

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

Future<bool> autoSessionRefresh() async {
  if (!await resumeSavedSession()) {
    if (!await startSessionWithSavedCredentials()) {
      return false;
    }
  }
  return true;
}

/// Attempts to restore the last session with the token stored in secure storage.
///
/// Returns true if the stored token exists and has not expired. This function does not make an api call and may return true even if the token has been invalidated on the server.
Future<bool> resumeSavedSession() async {
  final identityTokenString = await secureStorageRead(key: 'token');
  if (identityTokenString == null) return false;

  final identityTokenObject = IdentityToken.decode(identityTokenString);
  if (identityTokenObject == null) return false;

  identityToken = identityTokenString;
  return true;
}

/// Attempts to start a session using the uid and password stored in secure storage.
///
/// Returns true if both the uid and password exist and a call to startSession is successful.
Future<bool> startSessionWithSavedCredentials() async {
  final uidString = await secureStorageRead(key: 'uid');
  if (uidString == null || uidString.isEmpty) return false;

  final passwordString = await secureStorageRead(key: 'password');
  if (passwordString == null || passwordString.isEmpty) return false;

  return await startSession(uid: uidString, password: passwordString) == 200;
}

/// Ends the current session by setting identityToken to null, and deletes all credentials from secure storage.
void signOut() {
  identityToken = null;
  secureStorageDelete(key: 'uid');
  secureStorageDelete(key: 'password');
}

/// apiCallWithAuth: Gets the currently user's display name. This function is mostly used for testing.
///
/// Returns null if authentication fails.
Future<String?> getName() async {
  final response = await apiCallWithAuth('/auth/getName');
  if (response.statusCode == 200) {
    return response.bodyString;
  } else {
    return null;
  }
}

class User {
  final String id;
  final String name;

  User({
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
      );
}

Future<List<User>?> searchUsers(String query, {int? start, int? limit}) async {
  if (query.isEmpty || query.length > userNameMaxLength) return null;

  final response = await apiCallWithAuth('/auth/searchUser', headers: {
    'query': query,
    if (start != null) 'start': start.toString(),
    if (limit != null) 'limit': limit.toString(),
  });

  if (response.statusCode != 200) return null;
  return (jsonDecode(response.bodyString) as List).map((e) => User.fromJson(e)).toList();
}
