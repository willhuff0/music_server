import 'dart:io';

import 'package:just_audio/just_audio.dart';
import 'package:music_client/client/client.dart';
import 'package:music_shared/music_shared.dart';

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
