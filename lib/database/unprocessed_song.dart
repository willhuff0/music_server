import 'package:isar/isar.dart';
import 'package:music_server/music_server.dart';
import 'package:path/path.dart' as p;

part 'unprocessed_song.g.dart';

@collection
class UnprocessedSong {
  final String id;

  final String owner;

  final String name;
  final String description;

  final String fileExtension;

  final int numParts;
  int numPartsReceived;

  UnprocessedSong({
    required this.id,
    required this.owner,
    required this.name,
    required this.description,
    required this.fileExtension,
    required this.numParts,
    required this.numPartsReceived,
  });

  UnprocessedSong.create({
    required this.id,
    required this.owner,
    required this.name,
    required this.description,
    required this.fileExtension,
    required this.numParts,
  }) : numPartsReceived = 0;
}

String getUnprocessedSongInputFilePath(MusicServerPaths paths, String id, String fileExtension) => p.join(paths.storagePath, 'unprocessed_songs', id, 'input$fileExtension');
