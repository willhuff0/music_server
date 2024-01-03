import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:music_client/client/auth.dart';
import 'package:music_client/client/client.dart';
import 'package:music_client/client/song.dart';
import 'package:music_client/ui/mobile/app_scaffold.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

SyncSession? syncSession;

final syncSessionChangedController = StreamController<SyncSession?>.broadcast();
final syncSessionChanged = syncSessionChangedController.stream;

class SyncSession {
  final int port;
  final WebSocketChannel channel;

  late Timer _latencyCheckTimer;
  int latency = 0;
  int difference = 0;

  SyncSession._({required this.port, required this.channel}) {
    channel.stream.listen(_handle).onDone(() {
      disconnect();
    });

    time();
    _latencyCheckTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      time();
    });
  }

  static Future<SyncSession?> connect(int port) async {
    final uri = Uri(scheme: 'ws', host: serverHost, port: port, path: '/${identityTokenObject!.userId!}');
    final channel = WebSocketChannel.connect(uri);
    if (!await channel.ready.then((_) => true).timeout(const Duration(seconds: 10), onTimeout: () => false)) return null;
    return SyncSession._(port: port, channel: channel);
  }

  void _handle(dynamic request) {
    if (request is! String) {
      print('Malformed request: $request');
      return;
    }

    dynamic json;
    try {
      json = jsonDecode(request);
    } catch (e) {
      print('Malformed request: $request, $e');
      return;
    }

    switch (json['method']) {
      case 'time':
        _timeResponse(json);
        break;
      case 'callTimeSensitive':
        _callTimeSensitiveHandler(json);
        break;
      case 'call':
        _callHandler(json);
        break;
    }
  }

  DateTime? _clientSendTimestamp;
  Future<void> time() async {
    final message = jsonEncode({
      'method': 'time',
    });

    _clientSendTimestamp = DateTime.timestamp();
    channel.sink.add(message);
  }

  void _timeResponse(dynamic json) {
    final clientReceiveTimestamp = DateTime.timestamp();

    if (_clientSendTimestamp == null) return;

    //final serverReceivedTimestamp = DateTime.fromMicrosecondsSinceEpoch(json['received']);
    final serverSentTimestamp = DateTime.fromMicrosecondsSinceEpoch(json['sent']);

    final roundTripDuration = clientReceiveTimestamp.difference(_clientSendTimestamp!);

    // final toServerDuration = serverReceivedTimestamp.difference(_clientSendTimestamp!);
    final fromServerDuration = clientReceiveTimestamp.difference(serverSentTimestamp);

    // final inServerDuration = serverSentTimestamp.difference(serverSentTimestamp);

    // print('Round Trip: ${roundTripDuration.inMicroseconds / 1000} ms');
    // print('To Server: ${toServerDuration.inMicroseconds / 1000} ms');
    // print('From Server: ${fromServerDuration.inMicroseconds / 1000} ms');
    // print('In Server: ${inServerDuration.inMicroseconds / 1000} ms');

    latency = roundTripDuration.inMicroseconds ~/ 2;
    difference = fromServerDuration.inMicroseconds - latency; // TODO: account for dart execution duration

    syncSessionChangedController.add(syncSession);
  }

  void _callHandler(dynamic json) {
    switch (json['call']) {
      case 'load':
        _loadResponse(json['params']);
        break;
      case 'pause':
        _pauseResponse(json['params']);
        break;
      case 'seek':
        _seekResponse(json['params']);
        break;
    }
  }

  void _callTimeSensitiveHandler(dynamic json) {
    switch (json['call']) {
      case 'play':
        _playResponse(json);
        break;
    }
  }

  void load(Song song) {
    final message = jsonEncode({
      'method': 'call',
      'call': 'load',
      'params': song.toJson(),
    });
    channel.sink.add(message);
  }

  void _loadResponse(dynamic params) {
    preloadSong(Song.fromJson(params));
  }

  void play() async {
    final message = jsonEncode({
      'method': 'callTimeSensitive',
      'call': 'play',
    });
    channel.sink.add(message);
  }

  void _playResponse(dynamic json) async {
    _clientSendTimestamp = null;
    final effective = DateTime.fromMicrosecondsSinceEpoch(json['effective'] + difference);
    final microsecondsUntilCall = effective.difference(DateTime.timestamp()).inMicroseconds;
    sleep(Duration(microseconds: microsecondsUntilCall));
    await appPlayer.play();
  }

  void pause() async {
    await appPlayer.pause();
    final message = jsonEncode({
      'method': 'call',
      'call': 'pause',
      'params': appPlayer.position.inMicroseconds,
    });
    channel.sink.add(message);
  }

  void _pauseResponse(dynamic params) async {
    await appPlayer.pause();
    await appPlayer.seek(Duration(microseconds: params));
  }

  void seek(Duration position) {
    final message = jsonEncode({
      'method': 'call',
      'call': 'seek',
      'params': position.inMicroseconds,
    });
    channel.sink.add(message);
  }

  void _seekResponse(dynamic params) async {
    await appPlayer.pause();
    await appPlayer.seek(Duration(microseconds: params));
    await appPlayer.play();
    await appPlayer.pause();
    await appPlayer.seek(Duration(microseconds: params));
  }

  Future<void> disconnect() async {
    await channel.sink.close();
    _latencyCheckTimer.cancel();
  }
}

Future<bool> startOrJoinSyncSession() async {
  if (syncSession != null) {
    await syncSession!.disconnect();
  }

  final response = await apiCallWithAuth('/sync/startOrJoinSession');
  if (response.statusCode != 200) return false;

  final port = int.tryParse(response.bodyString);
  if (port == null) return false;

  syncSession = await SyncSession.connect(port);
  syncSessionChangedController.add(syncSession);
  if (syncSession == null) return false;

  return true;
}
