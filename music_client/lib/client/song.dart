import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_client/client/auth.dart';
import 'package:music_client/client/client.dart';
import 'package:music_client/ui/widgets/song_image.dart';
import 'package:music_shared/music_shared.dart';

class MusicServerAudioSource extends StreamAudioSource {
  final Song song;
  final AudioPreset preset;

  MusicServerAudioSource({required this.song, required this.preset})
      : super(
          tag: MediaItem(
            id: song.id,
            title: song.name,
            artist: song.ownerName,
            artUri: Uri.parse(getSongImageUrl(song.id, ImageSize.large)),
            duration: song.duration,
          ),
        );

  @override
  Duration? get duration => song.duration;

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    final request = await HttpClient().get(serverHost, serverPort, '/song/getData');
    request.headers.add('token', identityToken!);
    request.headers.add('songId', song.id);
    if (start != null) request.headers.add('start', start);
    if (end != null) request.headers.add('end', end);
    request.headers.add('format', preset.format.index);
    request.headers.add('quality', preset.quality.index);

    final response = await request.close();

    return StreamAudioResponse(
      sourceLength: int.parse(response.headers['source-length']!.first),
      contentLength: response.contentLength,
      offset: start,
      stream: response,
      contentType: preset.format.mimeType,
    );
  }
}

class Song {
  final String id;
  final String owner;
  final String ownerName;
  final DateTime timestamp;
  final Duration duration;
  final bool explicit;
  final String name;
  final String description;
  final int numPlays;

  Song({
    required this.id,
    required this.owner,
    required this.ownerName,
    required this.timestamp,
    required this.duration,
    required this.explicit,
    required this.name,
    required this.description,
    required this.numPlays,
  });

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        id: json['id'],
        owner: json['owner'],
        ownerName: json['ownerName'],
        timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
        duration: Duration(milliseconds: json['duration']),
        explicit: json['explicit'],
        name: json['name'],
        description: json['description'],
        numPlays: json['numPlays'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'owner': owner,
        'ownerName': ownerName,
        'timestamp': timestamp.millisecondsSinceEpoch,
        'duration': duration.inMilliseconds,
        'explicit': explicit,
        'name': name,
        'description': description,
        'numPlays': numPlays,
      };
}

Future<List<Song>?> searchSongs(String query, {int? start, int? limit}) async {
  if (query.isEmpty || query.length > 32) return null;

  final response = await apiCallWithAuth('/song/search', headers: {
    'query': query,
    if (start != null) 'start': start.toString(),
    if (limit != null) 'limit': limit.toString(),
  });

  if (response.statusCode != 200) return null;
  return (jsonDecode(response.bodyString) as List).map((e) => Song.fromJson(e)).toList();
}

Future<List<Song>?> filterSongs({String? owner, List<Genre>? genres, int? start, int? limit}) async {
  if (owner != null && owner.isEmpty) owner = null;
  if (genres != null && genres.isEmpty) genres = null;
  if (owner == null && genres == null) return null;

  final response = await apiCallWithAuth('/song/filter', headers: {
    if (owner != null) 'owner': owner,
    if (genres != null) 'genres': jsonEncode(genres.map((e) => e.index).toList()),
    if (start != null) 'start': start.toString(),
    if (limit != null) 'limit': limit.toString(),
  });

  if (response.statusCode != 200) return null;
  return (jsonDecode(response.bodyString) as List).map((e) => Song.fromJson(e)).toList();
}

Future<List<Song>?> popularSongs({int? limit}) async {
  final response = await apiCallWithAuth('/song/popular', headers: {
    if (limit != null) 'limit': limit.toString(),
  });

  if (response.statusCode != 200) return null;
  return (jsonDecode(response.bodyString) as List).map((e) => Song.fromJson(e)).toList();
}

Future<String?> createSong({required String fileExtension, required int numParts, required String name, required String description, required bool explicit, required Duration duration, required List<Genre> genres}) async {
  if (!validateSongName(name)) return null;
  if (!validateSongDescription(description)) return null;

  final bodyMap = {
    'fileExtension': fileExtension,
    'numParts': numParts,
    'name': name,
    'description': description,
    'duration': duration.inMilliseconds,
    'explicit': explicit,
    'genres': genres.map((e) => e.index).toList(),
  };
  final bodyJson = jsonEncode(bodyMap);

  final response = await apiCallWithAuth('/song/create', body: bodyJson);
  if (response.statusCode != 200) return null;
  return response.bodyString;
}

Future<bool> uploadSongData({required String songId, required int start, required Uint8List data}) async {
  final response = await apiCallWithAuth('/song/uploadData',
      headers: {
        'songId': songId,
        'start': start.toString(),
        'content-length': data.lengthInBytes.toString(),
      },
      body: data);

  return response.statusCode == 200;
}

Future<bool> uploadImageData({required String songId, required String fileExtension, required Uint8List data}) async {
  final response = await apiCallWithAuth('/song/uploadImage',
      headers: {
        'songId': songId,
        'fileExtension': fileExtension,
        'content-length': data.lengthInBytes.toString(),
      },
      body: data);

  return response.statusCode == 200;
}

Future<bool> finishSongUpload({required String songId}) async {
  final response = await apiCallWithAuth('/song/uploadDone', headers: {
    'songId': songId,
  });

  return response.statusCode == 200;
}
