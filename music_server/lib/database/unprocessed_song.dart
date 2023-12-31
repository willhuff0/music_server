import 'package:isar/isar.dart';
import 'package:music_server/music_server.dart';
import 'package:music_shared/music_shared.dart';
import 'package:path/path.dart' as p;

part 'unprocessed_song.g.dart';

@collection
class UnprocessedSong {
  Id isarId;

  @Index(unique: true)
  final String id;

  final String owner;

  final int duration;

  @enumerated
  final List<Genre> genres;

  final bool explicit;

  final String name;
  final String description;

  final String fileExtension;

  final int numParts;
  int numPartsReceived;

  String? imageFileExtension;

  UnprocessedSong({
    this.isarId = Isar.autoIncrement,
    required this.id,
    required this.owner,
    required this.duration,
    required this.genres,
    required this.explicit,
    required this.name,
    required this.description,
    required this.fileExtension,
    required this.numParts,
    required this.numPartsReceived,
    required this.imageFileExtension,
  });

  UnprocessedSong.create({
    this.isarId = Isar.autoIncrement,
    required this.id,
    required this.owner,
    required this.duration,
    required this.genres,
    required this.explicit,
    required this.name,
    required this.description,
    required this.fileExtension,
    required this.numParts,
  }) : numPartsReceived = 0;
}

String getUnprocessedSongAudioInputFilePath(MusicServerPaths paths, String id, String fileExtension) => p.join(paths.storagePath, 'unprocessed_songs', id, 'audio$fileExtension');
String getUnprocessedSongImageInputFilePath(MusicServerPaths paths, String id, String imageFileExtension) => p.join(paths.storagePath, 'unprocessed_songs', id, 'image$imageFileExtension');
