import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:isar/isar.dart';
import 'package:music_server/database/song.dart';
import 'package:music_server/database/transcode_operation.dart';
import 'package:music_server/database/unprocessed_song.dart';
import 'package:music_server/database/user.dart';
import 'package:music_server/music_server.dart';
import 'package:music_server/phonetics.dart';
import 'package:music_server/stateless_server/stateless_server.dart';
import 'package:music_shared/music_shared.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

const maxUploadChunkBytes = 100 * 1000 * 1000;
const maxImageUploadBytes = 100 * 1000 * 1000;

final _uuid = Uuid();

FutureOr<Response> songCreateHandler(Request request, MusicServerThreadData threadData, IdentityToken<MusicServerIdentityTokenClaims> identityToken) async {
  if (identityToken.userId == null) return Response.unauthorized('');
  if (!identityToken.claims.canSongCreate()) return Response.unauthorized('');

  final map = jsonDecode(await request.readAsString()) as Map<String, dynamic>;

  final fileExtension = map['fileExtension'] as String?;
  if (fileExtension == null) return Response.badRequest();

  final numParts = map['numParts'] as int?;
  if (numParts == null || numParts < 1) return Response.badRequest();

  final name = map['name'] as String?;
  if (name == null) return Response.badRequest();
  if (!validateSongName(name)) return Response.badRequest();

  final description = map['description'] as String?;
  if (description == null) return Response.badRequest();
  if (!validateSongDescription(description)) return Response.badRequest();

  final duration = map['duration'] as int?;
  if (duration == null || duration < 1) return Response.badRequest();

  final explicit = map['explicit'] as bool?;
  if (explicit == null) return Response.badRequest();

  final genreInts = (map['genres'] as List?)?.cast<int?>();
  if (genreInts == null || genreInts.isEmpty) return Response.badRequest();
  final genres = <Genre>{};
  for (final genreInt in genreInts) {
    if (genreInt == null || genreInt < 0 || genreInt > Genre.values.length) return Response.badRequest();
    genres.add(Genre.values[genreInt]);
  }

  final songId = _uuid.v7();
  final owner = identityToken.userId!;

  final unprocessedSong = UnprocessedSong.create(
    id: songId,
    owner: owner,
    duration: duration,
    genres: genres.toList(),
    explicit: explicit,
    name: name,
    description: description,
    fileExtension: fileExtension,
    numParts: numParts,
  );

  threadData.isar.writeTxnSync(() => threadData.isar.unprocessedSongs.putByIdSync(unprocessedSong));

  return Response.ok(songId);
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

  if (unprocessedSong.owner != identityToken.userId) return Response.unauthorized('');

  final inputPath = getUnprocessedSongAudioInputFilePath(threadData.paths, unprocessedSong.id, unprocessedSong.fileExtension);

  final inputFile = File(inputPath);
  if (!inputFile.existsSync()) inputFile.createSync(recursive: true);
  final randomAccessFile = inputFile.openSync(mode: FileMode.writeOnlyAppend);

  randomAccessFile.setPositionSync(start);

  var length = 0;
  await for (final part in request.read()) {
    length += part.length;
    if (length > maxUploadChunkBytes) return Response.badRequest();

    randomAccessFile.writeFromSync(part);
  }

  randomAccessFile.flushSync();
  randomAccessFile.closeSync();

  unprocessedSong.numPartsReceived++;
  threadData.isar.writeTxnSync(() => threadData.isar.unprocessedSongs.putByIdSync(unprocessedSong));

  return Response.ok('');
}

FutureOr<Response> songUploadImageHandler(Request request, MusicServerThreadData threadData, IdentityToken identityToken) async {
  final contentLength = request.contentLength;
  if (contentLength == null || contentLength > maxImageUploadBytes) return Response.badRequest();

  final songId = request.headers['songId'];
  if (songId == null) return Response.badRequest();

  final fileExtension = request.headers['fileExtension'];
  if (fileExtension == null) return Response.badRequest();

  final unprocessedSong = threadData.isar.unprocessedSongs.getByIdSync(songId);
  if (unprocessedSong == null) return Response.notFound('');

  if (unprocessedSong.owner != identityToken.userId) return Response.unauthorized('');

  final inputPath = getUnprocessedSongImageInputFilePath(threadData.paths, unprocessedSong.id, fileExtension);

  final inputFile = File(inputPath);
  if (!inputFile.existsSync()) inputFile.createSync(recursive: true);
  final randomAccessFile = inputFile.openSync(mode: FileMode.writeOnly);

  var length = 0;
  await for (final part in request.read()) {
    length += part.length;
    if (length > maxImageUploadBytes) return Response.badRequest();

    randomAccessFile.writeFromSync(part);
  }

  randomAccessFile.flushSync();
  randomAccessFile.closeSync();

  unprocessedSong.imageFileExtension = fileExtension;
  threadData.isar.writeTxnSync(() => threadData.isar.unprocessedSongs.putByIdSync(unprocessedSong));

  return Response.ok('');
}

FutureOr<Response> songUploadDoneHandler(Request request, MusicServerThreadData threadData, IdentityToken identityToken) {
  final songId = request.headers['songId'];
  if (songId == null) return Response.badRequest();

  final unprocessedSong = threadData.isar.unprocessedSongs.getByIdSync(songId);
  if (unprocessedSong == null) return Response.notFound('');

  if (unprocessedSong.owner != identityToken.userId) return Response.unauthorized('');

  if (unprocessedSong.numPartsReceived < unprocessedSong.numParts) return Response.notModified();
  if (unprocessedSong.imageFileExtension == null) return Response.notModified();

  threadData.isar.writeTxnSync(() => threadData.isar.transcodeOperations.putBySongIdSync(TranscodeOperation(songId: songId, timestamp: DateTime.timestamp().millisecondsSinceEpoch)));

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

  final audioFile = File(getSongAudioFilePath(threadData.paths, songId, preset));
  if (!audioFile.existsSync()) return Response.notFound('');

  final audioFileLength = audioFile.lengthSync();

  int length;
  if (end != null) {
    if (start != null) {
      length = end - start;
    } else {
      length = end;
    }
  } else {
    if (start != null) {
      length = audioFileLength - start;
    } else {
      length = audioFileLength;
    }
  }
  length = min(length, audioFileLength);

  return Response.ok(audioFile.openRead(start, end), headers: {
    'content-type': 'audio/${preset.format.fileType}',
    'content-length': length.toString(),
    'source-length': audioFileLength.toString(),
  });
}

FutureOr<Response> songGetImageHandler(Request request, MusicServerThreadData threadData) {
  final songId = request.params['songId'];
  if (songId == null) return Response.badRequest();

  ImageSize size;
  final sizeString = request.params['size'];
  if (sizeString == null) {
    size = ImageSize.thumb;
  } else {
    final sizeInt = int.tryParse(p.basenameWithoutExtension(sizeString));
    if (sizeInt == null || sizeInt < 0 || sizeInt >= ImageSize.values.length) return Response.badRequest();
    size = ImageSize.values[sizeInt];
  }

  final imageFile = File(getSongImageFilePath(threadData.paths, songId, size));
  if (!imageFile.existsSync()) return Response.notFound('');

  return Response.ok(imageFile.openRead(), headers: {'content-type': 'image/webp'});
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
    if (limitInt == null || limitInt < 1 || limitInt > 10) return Response.badRequest();
    limit = limitInt;
  } else {
    limit = 10;
  }

  final queryPhonetics = getPhoneticCodesOfQuery(queryString);
  final searchResults = threadData.isar.songs.where().anyOf(queryPhonetics, (q, element) => q.namePhoneticsElementEqualTo(element)).sortByPopularityDesc().offset(start).limit(limit).findAllSync();

  return Response.ok(jsonEncode(searchResults.map((song) => song.toJson()).toList()));
}

FutureOr<Response> songFilterHandler(Request request, MusicServerThreadData threadData, IdentityToken identityToken) {
  final ownerString = request.headers['owner'];
  if (ownerString != null && ownerString.isEmpty) return Response.badRequest();

  final genresString = request.headers['genres'];
  Set<Genre>? genres;
  if (genresString != null) {
    final genreInts = (jsonDecode(genresString) as List?)?.cast<int?>();
    if (genreInts == null || genreInts.isEmpty) return Response.badRequest();
    genres = <Genre>{};
    for (final genreInt in genreInts) {
      if (genreInt == null || genreInt < 0 || genreInt > Genre.values.length) return Response.badRequest();
      genres.add(Genre.values[genreInt]);
    }
  }

  if (ownerString == null && genresString == null) return Response.badRequest();

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
    if (limitInt == null || limitInt < 1 || limitInt > 10) return Response.badRequest();
    limit = limitInt;
  } else {
    limit = 10;
  }

  List<Song> filterResult;
  if (ownerString == null) {
    filterResult = threadData.isar.songs.where().anyOf(genres!, (q, element) => q.genresElementEqualTo(element)).sortByPopularityDesc().offset(start).limit(limit).findAllSync();
  } else {
    var query = threadData.isar.songs.where().ownerEqualTo(ownerString);
    if (genres != null) {
      filterResult = query.filter().anyOf(genres, (q, element) => q.genresElementEqualTo(element)).sortByPopularityDesc().offset(start).limit(limit).findAllSync();
    } else {
      filterResult = query.sortByPopularityDesc().offset(start).limit(limit).findAllSync();
    }
  }

  return Response.ok(jsonEncode(filterResult.map((song) => song.toJson()).toList()));
}

const decreaseUserFavorsEvery = Duration(days: 1);
const minUserFavorsDecrease = 0.8;
const maxUserFavorsDecrease = 0.3;
const userFavorsDecreaseSteps = 7 - 1;

const decreaseSongPopularityEvery = Duration(hours: 12);
const minSongPopularityDecrease = 0.7;
const maxSongPopularityDecrease = 0.2;
const songPopularityDecreaseSteps = 4 - 1;

FutureOr<Response> songPopularHandler(Request request, MusicServerThreadData threadData, IdentityToken identityToken) {
  int limit;
  final limitString = request.headers['limit'];
  if (limitString != null) {
    final limitInt = int.tryParse(limitString);
    if (limitInt == null || limitInt < 1 || limitInt > 6) return Response.badRequest();
    limit = limitInt;
  } else {
    limit = 6;
  }

  final userId = identityToken.userId;
  if (userId == null) return Response.unauthorized('');
  final user = threadData.isar.users.getByIdSync(userId);
  if (user == null) return Response.unauthorized('');

  final timestamp = DateTime.timestamp();

  var userChanged = false;
  final lastUserCheckDifference = timestamp.difference(user.lastFavorCheck).inMinutes;
  if (lastUserCheckDifference > decreaseUserFavorsEvery.inMinutes) {
    final steps = lastUserCheckDifference / decreaseUserFavorsEvery.inMinutes - 1;
    final multiplier = lerpDouble(minUserFavorsDecrease, maxUserFavorsDecrease, clamp(steps / userFavorsDecreaseSteps, 0.0, 1.0));
    for (var i = 0; i < user.favors.length; i++) {
      user.favors[i].favor *= multiplier;
    }
    userChanged = true;
  }

  final topGenres = user.getTopGenres(4);
  var results = threadData.isar.songs.where().anyOf(topGenres, (q, element) => q.genresElementEqualTo(element.genre)).sortByPopularityDesc().limit(limit).findAllSync();
  if (results.length < limit) {
    final extras = threadData.isar.songs.where().anyOf(results, (q, element) => q.isarIdNotEqualTo(element.isarId)).sortByPopularityDesc().limit(limit - results.length).findAllSync();
    results = [...results, ...extras];
  }

  threadData.isar.writeTxnSync(() {
    if (userChanged) threadData.isar.users.putSync(user);

    for (final song in results) {
      final lastSongPopularityCheckDifference = timestamp.difference(song.lastPopularityCheck).inMinutes;
      if (lastSongPopularityCheckDifference > decreaseSongPopularityEvery.inMinutes) {
        final steps = lastSongPopularityCheckDifference / decreaseSongPopularityEvery.inMinutes - 1;
        final multiplier = lerpDouble(minSongPopularityDecrease, maxSongPopularityDecrease, clamp(steps / songPopularityDecreaseSteps, 0.0, 1.0));
        song.popularity *= multiplier;
      }
      threadData.isar.songs.putSync(song);
    }
  });

  return Response.ok(jsonEncode(results.map((e) => e.toJson()).toList()));
}

double lerpDouble(double a, double b, double t) => a * (1.0 - t) + b * t;

double clamp(double x, double lower, double upper) => max(min(x, upper), lower);
