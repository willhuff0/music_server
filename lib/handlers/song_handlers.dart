import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:music_server/database/song.dart';
import 'package:music_server/database/transcode_operation.dart';
import 'package:music_server/music_server.dart';
import 'package:stateless_server/stateless_server.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

FutureOr<Response> createSongHandler(Request request, MusicServerThreadData threadData, IdentityToken identityToken) async {
  if (identityToken.userId == null) return Response.forbidden('');

  final map = jsonDecode(await request.readAsString()) as Map<String, dynamic>;

  final fileType = map['fileType'] as String?;
  if (fileType == null) return Response.badRequest();

  final numPartsString = map['numParts'] as String?;
  if (numPartsString == null) return Response.badRequest();
  final numParts = int.tryParse(numPartsString);
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
    fileType: fileType,
    numParts: numParts,
  );

  threadData.isar.write((isar) => isar.unprocessedSongs.put(unprocessedSong));

  return Response.ok('Success');
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

FutureOr<Response> uploadSongData(Request request, MusicServerThreadData threadData, IdentityToken identityToken) async {
  final songId = request.headers['songId'];
  if (songId == null) return Response.badRequest();

  final startString = request.headers['start'];
  if (startString == null) return Response.badRequest();
  final start = int.tryParse(startString);
  if (start == null) return Response.badRequest();

  final unprocessedSong = threadData.isar.unprocessedSongs.get(songId);
  if (unprocessedSong == null) return Response.notFound('');

  if (unprocessedSong.owner != identityToken.userId) return Response.forbidden('');

  final inputPath = unprocessedSong.getInputFilePath();

  final data = await request.read().fold(<int>[], (previous, element) => previous..addAll(element));

  final randomAccessFile = File(inputPath).openSync();
  randomAccessFile.setPositionSync(start);
  randomAccessFile.writeFromSync(data);
  randomAccessFile.flushSync();
  randomAccessFile.closeSync();

  unprocessedSong.numPartsReceived++;
  if (unprocessedSong.numPartsReceived >= unprocessedSong.numParts) {
    threadData.isar.write((isar) => isar.transcodeOperations.put(TranscodeOperation(songId)));
  } else {
    threadData.isar.write((isar) => isar.unprocessedSongs.put(unprocessedSong));
  }

  return Response.ok('');
}
