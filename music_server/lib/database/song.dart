import 'package:isar/isar.dart';
import 'package:music_server/database/unprocessed_song.dart';
import 'package:music_server/database/user.dart';
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

  final ownerUser = IsarLink<User>();

  final int duration;

  @Index(type: IndexType.value)
  @enumerated
  final List<Genre> genres;

  final bool explicit;

  final DateTime timestamp;

  final String name;

  final Set<String> _namePhonetics;
  @Index(type: IndexType.value, caseSensitive: false)
  List<String> get namePhonetics => _namePhonetics.toList();

  final String description;

  int numPlays;

  @Index(type: IndexType.value)
  double popularity;
  DateTime lastPopularityCheck;

  Song({
    this.isarId = Isar.autoIncrement,
    required this.id,
    required this.owner,
    required this.duration,
    required this.genres,
    required this.explicit,
    required this.timestamp,
    required this.name,
    required List<String> namePhonetics,
    required this.description,
    required this.numPlays,
    required this.popularity,
    required this.lastPopularityCheck,
  }) : _namePhonetics = namePhonetics.toSet();

  Song.create({this.isarId = Isar.autoIncrement, required this.id, required User owner, required this.duration, required this.explicit, required this.genres, required this.name, required this.description})
      : owner = owner.id,
        timestamp = DateTime.now().toUtc(),
        _namePhonetics = getPhoneticCodesOfQuery(name),
        numPlays = 0,
        popularity = 1.0,
        lastPopularityCheck = DateTime.timestamp() {
    ownerUser.value = owner;
  }

  Song.createFromUnprocessed(UnprocessedSong unprocessedSong, User owner, {this.isarId = Isar.autoIncrement})
      : id = unprocessedSong.id,
        owner = unprocessedSong.owner,
        duration = unprocessedSong.duration,
        genres = unprocessedSong.genres,
        explicit = unprocessedSong.explicit,
        timestamp = DateTime.now().toUtc(),
        name = unprocessedSong.name,
        _namePhonetics = getPhoneticCodesOfQuery(unprocessedSong.name),
        description = unprocessedSong.description,
        numPlays = 0,
        popularity = 1.0,
        lastPopularityCheck = DateTime.timestamp() {
    ownerUser.value = owner;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'owner': owner,
        if (ownerUser.value != null) 'ownerName': ownerUser.value!.name,
        'duration': duration,
        'explicit': explicit,
        'timestamp': timestamp.millisecondsSinceEpoch,
        'name': name,
        'description': description,
        'numPlays': numPlays,
      };
}

String getSongStorageDir(MusicServerPaths paths, String id) => p.join(paths.storagePath, 'songs', id);
String getSongAudioFilePath(MusicServerPaths paths, String id, AudioPreset preset) => p.join(paths.storagePath, 'songs', id, 'audio', '${preset.quality.outputFileName}.${preset.format.fileType}');
String getSongImageFilePath(MusicServerPaths paths, String id, ImageSize size) => p.join(paths.storagePath, 'songs', id, 'images', '${size.resolution}.webp');
