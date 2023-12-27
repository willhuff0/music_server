import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:music_client/client/auth.dart';
import 'package:music_shared/music_shared.dart';

const serverHost = '127.0.0.1';
const serverPort = 8081;
final serverUri = Uri(host: serverHost, port: serverPort, scheme: 'http'); // TODO: enforce https

late DeviceSpeed deviceSpeed;

enum DeviceSpeed { disconnected, slow, medium, fast, veryFast }

void runSpeedTestOnConnectivityChanged() {
  Connectivity().onConnectivityChanged.listen((connectivity) {
    if (connectivity == ConnectivityResult.none) {
      deviceSpeed = DeviceSpeed.disconnected;
    } else {
      _runSpeedTest();
    }
  });
}

Future<void> _runSpeedTest() async {
  const iterations = 4;

  final uri = serverUri.replace(path: '/speedTest/.5');

  final stopwatch = Stopwatch()..start();
  for (var i = 0; i < iterations; i++) {
    await http.get(uri);
  }
  stopwatch.stop();

  double averageDurationSeconds = stopwatch.elapsedMilliseconds / 1000 / iterations;
  double speedMBps = .5 / averageDurationSeconds;

  deviceSpeed = switch (speedMBps) {
    > 12.0 => DeviceSpeed.veryFast,
    > 6.0 => DeviceSpeed.fast,
    > 3.0 => DeviceSpeed.medium,
    _ => DeviceSpeed.slow,
  };
}

class MusicServerAudioSource extends StreamAudioSource {
  final String token;
  final String songId;
  final AudioPreset preset;

  MusicServerAudioSource({super.tag, required this.token, required this.songId, required this.preset});

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    final request = await HttpClient().get(serverHost, serverPort, '/song/getData');
    request.headers.add('token', token);
    request.headers.add('songId', songId);
    if (start != null) request.headers.add('start', start);
    if (end != null) request.headers.add('end', end);
    request.headers.add('format', preset.format.index);
    request.headers.add('quality', preset.quality.index);

    final response = await request.close();

    return StreamAudioResponse(
      sourceLength: null,
      contentLength: null,
      offset: null,
      stream: response,
      contentType: 'audio/${preset.format.fileType}',
    );
  }
}

class ApiResponse {
  final int statusCode;
  final Map<String, String> headers;
  final Uint8List body;

  ApiResponse({required this.statusCode, required this.headers, required this.body});

  String get bodyString => utf8.decode(body);
}

/// Calls an api on the server.
Future<ApiResponse> apiCall(String route, {Map<String, String> headers = const {}, Uint8List? body}) async {
  final response = await http.put(serverUri.resolve(route), headers: headers, body: body);
  return ApiResponse(statusCode: response.statusCode, headers: response.headers, body: response.bodyBytes);
}

/// Calls an api on the server and automatically includes the authentication headers.
///
/// Returns an empty ApiResponse with status code 403 if identityToken is null and autoSessionRefresh fails.
///
/// If the server responds with status code 403, this function will call startSessionWithSavedCredentials and retry the api call if a session was started.
Future<ApiResponse> apiCallWithAuth(String route, {Map<String, String> headers = const {}, Uint8List? body}) => _apiCallWithAuth(route, headers: headers, body: body);

Future<ApiResponse> _apiCallWithAuth(String route, {Map<String, String> headers = const {}, Uint8List? body, int retryCountInternal = 0}) async {
  if (identityToken == null) {
    if (!await autoSessionRefresh()) {
      signOut();
      return ApiResponse(statusCode: 403, headers: {}, body: Uint8List(0));
    }
  }
  final headersWithAuth = {
    ...headers,
    'token': identityToken!,
  };

  final response = await http.put(serverUri.resolve(route), headers: headersWithAuth, body: body);
  final apiResponse = ApiResponse(statusCode: response.statusCode, headers: response.headers, body: response.bodyBytes);
  switch (response.statusCode) {
    case 403:
      if (retryCountInternal < 1 && await startSessionWithSavedCredentials()) {
        return _apiCallWithAuth(route, headers: headersWithAuth, body: body, retryCountInternal: retryCountInternal + 1);
      } else {
        signOut();
        return apiResponse;
      }
    default:
      return apiResponse;
  }
}
