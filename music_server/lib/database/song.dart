import 'package:isar/isar.dart';
import 'package:music_server/database/unprocessed_song.dart';
import 'package:music_server/music_server.dart';
import 'package:music_server/phonetics.dart';
import 'package:music_shared/music_shared.dart';
import 'package:path/path.dart' as p;

part 'song.g.dart';

@collection
class Song {
  Id isarId;

  @Index(unique: true)
  final String id;

  @Index()
  final String owner;

  @Index(type: IndexType.value)
  @enumerated
  final List<Genre> genres;

  final DateTime timestamp;

  final String name;

  final Set<String> _namePhonetics;
  @Index(type: IndexType.value, caseSensitive: false)
  List<String> get namePhonetics => _namePhonetics.toList();

  final String description;

  final int numPlays;

  Song({
    this.isarId = Isar.autoIncrement,
    required this.id,
    required this.owner,
    required this.genres,
    required this.timestamp,
    required this.name,
    required List<String> namePhonetics,
    required this.description,
    this.numPlays = 0,
  }) : _namePhonetics = namePhonetics.toSet();

  Song.create({this.isarId = Isar.autoIncrement, required this.id, required this.owner, required this.genres, required this.name, required this.description})
      : timestamp = DateTime.now().toUtc(),
        _namePhonetics = getPhoneticCodesOfQuery(name),
        numPlays = 0;

  Song.createFromUnprocessed(UnprocessedSong unprocessedSong, {this.isarId = Isar.autoIncrement})
      : id = unprocessedSong.id,
        owner = unprocessedSong.owner,
        genres = unprocessedSong.genres,
        timestamp = DateTime.now().toUtc(),
        name = unprocessedSong.name,
        _namePhonetics = getPhoneticCodesOfQuery(unprocessedSong.name),
        description = unprocessedSong.description,
        numPlays = 0;

  Map<String, dynamic> toJson() => {
        'id': id,
        'owner': owner,
        'timestamp': timestamp.millisecondsSinceEpoch,
        'name': name,
        'description': description,
        'numPlays': numPlays,
      };
}

String getSongStorageDir(MusicServerPaths paths, String id) => p.join(paths.storagePath, 'songs', id);
String getSongAudioFilePath(MusicServerPaths paths, String id, AudioPreset preset) => p.join(paths.storagePath, 'songs', id, 'audio', '${preset.quality.outputFileName}.${preset.format.fileType}');
String getSongImageFilePath(MusicServerPaths paths, String id, ImageSize size) => p.join(paths.storagePath, 'songs', id, 'images', '${size.resolution}.webp');
