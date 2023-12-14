import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:isar/isar.dart';
import 'package:music_server/audio_processing.dart';
import 'package:music_server/database/song.dart';
import 'package:music_server/database/transcode_operation.dart';
import 'package:music_server/database/unprocessed_song.dart';
import 'package:music_server/music_server.dart';
import 'package:music_server/stateless_server/stateless_server.dart';
import 'package:uuid/uuid.dart';

const maxUploadChunkBytes = 100 * 1000 * 1000;

final _uuid = Uuid();

FutureOr<Response> songCreateHandler(Request request, MusicServerThreadData threadData, IdentityToken<MusicServerIdentityTokenClaims> identityToken) async {
  if (identityToken.userId == null) return Response.forbidden('');
  if (!identityToken.claims.canSongCreate()) return Response.forbidden('');

  final map = jsonDecode(await request.readAsString()) as Map<String, dynamic>;

  final fileExtension = map['fileExtension'] as String?;
  if (fileExtension == null) return Response.badRequest();

  final numParts = map['numParts'] as int?;
  if (numParts == null) return Response.badRequest();

  final name = map['name'] as String?;
  if (name == null) return Response.badRequest();
  if (!_validateNewSongName(name)) return Response.badRequest();

  final description = map['description'] as String?;
  if (description == null) return Response.badRequest();
  if (!_validateNewSongDescription(description)) return Response.badRequest();

  final songId = _uuid.v7();
  final owner = identityToken.userId!;

  final unprocessedSong = UnprocessedSong.create(
    id: songId,
    owner: owner,
    name: name,
    description: description,
    fileExtension: fileExtension,
    numParts: numParts,
  );

  threadData.isar.writeTxnSync(() => threadData.isar.unprocessedSongs.putByIdSync(unprocessedSong));

  return Response.ok(songId);
}

bool _validateNewSongName(String name) {
  const minLength = 1;
  const maxLength = 50;

  if (name.length < minLength || name.length > maxLength) return false;

  return true;
}

bool _validateNewSongDescription(String description) {
  const maxLength = 100;

  if (description.length > maxLength) return false;

  return true;
}

FutureOr<Response> songUploadDataHandler(Request request, MusicServerThreadData threadData, IdentityToken identityToken) async {
  final contentLength = request.contentLength;
  if (contentLength == null || contentLength > maxUploadChunkBytes) return Response.badRequest();

  final songId = request.headers['songId'];
  if (songId == null) return Response.badRequest();

  final startString = request.headers['start'];
  if (startString == null) return Response.badRequest();
  final start = int.tryParse(startString);
  if (start == null) return Response.badRequest();

  final unprocessedSong = threadData.isar.unprocessedSongs.getByIdSync(songId);
  if (unprocessedSong == null) return Response.notFound('');

  if (unprocessedSong.owner != identityToken.userId) return Response.forbidden('');

  final inputPath = getUnprocessedSongInputFilePath(threadData.paths, unprocessedSong.id, unprocessedSong.fileExtension);

  final data = <int>[];
  var length = 0;
  await for (final part in request.read()) {
    length += part.length;
    if (length > maxUploadChunkBytes) return Response.badRequest();

    data.addAll(part);
  }

  final inputFile = File(inputPath);
  if (!inputFile.existsSync()) inputFile.createSync(recursive: true);
  final randomAccessFile = inputFile.openSync(mode: FileMode.writeOnlyAppend);
  randomAccessFile.setPositionSync(start);
  randomAccessFile.writeFromSync(data);
  randomAccessFile.flushSync();
  randomAccessFile.closeSync();

  unprocessedSong.numPartsReceived++;
  if (unprocessedSong.numPartsReceived >= unprocessedSong.numParts) {
    threadData.isar.writeTxnSync(() => threadData.isar.transcodeOperations.putSync(TranscodeOperation(songId: songId, timestamp: DateTime.timestamp().millisecondsSinceEpoch)));
  } else {
    threadData.isar.writeTxnSync(() => threadData.isar.unprocessedSongs.putByIdSync(unprocessedSong));
  }

  return Response.ok('');
}

FutureOr<Response> songGetDataHandler(Request request, MusicServerThreadData threadData, IdentityToken<MusicServerIdentityTokenClaims> identityToken) {
  if (!identityToken.claims.canSongGetData()) return Response.forbidden('');

  final songId = request.headers['songId'];
  if (songId == null) return Response.badRequest();

  int? start;
  final startString = request.headers['start'];
  if (startString != null) {
    start = int.tryParse(startString);
    if (start == null) return Response.badRequest();
  }

  int? end;
  final endString = request.headers['end'];
  if (endString != null) {
    end = int.tryParse(endString);
    if (end == null) return Response.badRequest();
  }

  CompressedAudioFormat format;
  final formatString = request.headers['format'];
  if (formatString == null) {
    format = CompressedAudioFormat.aac;
  } else {
    final formatInt = int.tryParse(formatString);
    if (formatInt == null || formatInt < 0 || formatInt >= CompressedAudioFormat.values.length) return Response.badRequest();
    format = CompressedAudioFormat.values[formatInt];
  }

  CompressedAudioQuality quality;
  final qualityString = request.headers['quality'];
  if (qualityString == null) {
    quality = CompressedAudioQuality.high;
  } else {
    final qualityInt = int.tryParse(qualityString);
    if (qualityInt == null || qualityInt < 0 || qualityInt >= CompressedAudioQuality.values.length) return Response.badRequest();
    quality = CompressedAudioQuality.values[qualityInt];
  }

  final preset = AudioPreset(format: format, quality: quality);

  final songFile = File(getSongFilePath(threadData.paths, songId, preset));
  if (!songFile.existsSync()) return Response.notFound('');

  return Response.ok(songFile.openRead(start, end), headers: {'content-type': 'audio/${preset.format.fileType}'});
}

FutureOr<Response> songSearchHandler(Request request, MusicServerThreadData threadData, IdentityToken identityToken) {
  final queryString = request.headers['query'];
  if (queryString == null || queryString.isEmpty || queryString.length > 32) return Response.badRequest();

  int start;
  final startString = request.headers['start'];
  if (startString != null) {
    final startInt = int.tryParse(startString);
    if (startInt == null || startInt < 0) return Response.badRequest();
    start = startInt;
  } else {
    start = 0;
  }

  int limit;
  final limitString = request.headers['limit'];
  if (limitString != null) {
    final limitInt = int.tryParse(limitString);
    if (limitInt == null || limitInt < 0 || limitInt > 10) return Response.badRequest();
    limit = limitInt;
  } else {
    limit = 10;
  }

  final queryPhonetics = getPhoneticCodesOfQuery(queryString);
  final searchResults = threadData.isar.songs.where().anyOf(queryPhonetics, (q, element) => q.namePhoneticsElementEqualTo(element)).offset(start).limit(limit).findAllSync();

  return Response.ok(jsonEncode(searchResults.map((song) => song.toJson()).toList()));
}
