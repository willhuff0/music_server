import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:music_server/database/transcode_operation.dart';
import 'package:music_server/database/unprocessed_song.dart';
import 'package:music_server/music_server.dart';
import 'package:stateless_server/stateless_server.dart';
import 'package:uuid/uuid.dart';

const maxUploadChunkBytes = 100 * 1000 * 1000;

final _uuid = Uuid();

FutureOr<Response> songCreateHandler(Request request, MusicServerThreadData threadData, IdentityToken identityToken) async {
  if (identityToken.userId == null) return Response.forbidden('');

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
    if (length > maxUploadChunkBytes) return Response.forbidden('');

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
