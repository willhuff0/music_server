import 'package:isar/isar.dart';
import 'package:music_server/music_server.dart';
import 'package:path/path.dart' as p;

part 'song.g.dart';

@collection
class Song {
  final String id;

  final String owner;

  final bool public;

  final String name;
  final String description;

  final int numPlays;

  Song({
    required this.id,
    required this.owner,
    required this.public,
    required this.name,
    required this.description,
    this.numPlays = 0,
  });

  Song.create({required this.id, required this.owner, required this.name, required this.description})
      : public = false,
        numPlays = 0;

  Song.createFromUnprocessed(UnprocessedSong unprocessedSong)
      : id = unprocessedSong.id,
        owner = unprocessedSong.owner,
        name = unprocessedSong.name,
        description = unprocessedSong.description,
        public = false,
        numPlays = 0;
}

@collection
class UnprocessedSong {
  final String id;

  final String owner;

  final String name;
  final String description;

  final String fileType;

  final int numParts;
  int numPartsReceived;

  UnprocessedSong({
    required this.id,
    required this.owner,
    required this.name,
    required this.description,
    required this.fileType,
    required this.numParts,
    required this.numPartsReceived,
  });

  UnprocessedSong.create({
    required this.id,
    required this.owner,
    required this.name,
    required this.description,
    required this.fileType,
    required this.numParts,
  }) : numPartsReceived = 0;

  String getInputFilePath() => p.join(storagePath, 'unprocessed_songs', id, 'input.$fileType');

  String getOutputOpusFilePath() => p.join(storagePath, 'unprocessed_songs', id, 'output.opus');
  String getOutputAACFilePath() => p.join(storagePath, 'unprocessed_songs', id, 'output.aac');
}
