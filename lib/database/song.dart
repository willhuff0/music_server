import 'package:dart_phonetics/dart_phonetics.dart';
import 'package:isar/isar.dart';
import 'package:music_server/audio_processing.dart';
import 'package:music_server/database/unprocessed_song.dart';
import 'package:music_server/music_server.dart';
import 'package:path/path.dart' as p;

part 'song.g.dart';

final _phoneticsEncoder = DoubleMetaphone();

@collection
class Song {
  Id isarId;

  @Index(unique: true)
  final String id;

  final String owner;

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
    required this.timestamp,
    required this.name,
    required List<String> namePhonetics,
    required this.description,
    this.numPlays = 0,
  }) : _namePhonetics = namePhonetics.toSet();

  Song.create({this.isarId = Isar.autoIncrement, required this.id, required this.owner, required this.name, required this.description})
      : timestamp = DateTime.now().toUtc(),
        _namePhonetics = getPhoneticCodesOfQuery(name),
        numPlays = 0;

  Song.createFromUnprocessed(UnprocessedSong unprocessedSong, {this.isarId = Isar.autoIncrement})
      : id = unprocessedSong.id,
        owner = unprocessedSong.owner,
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
String getSongFilePath(MusicServerPaths paths, String id, AudioPreset preset) => p.join(paths.storagePath, 'songs', id, '${preset.quality.outputFileName}.${preset.format.fileType}');

Set<String> getPhoneticCodesOfWord(String word) {
  final phonetic = _phoneticsEncoder.encode(word)!;
  return {
    phonetic.primary,
    ...?phonetic.alternates,
  };
}

Set<String> getPhoneticCodesOfQuery(String query) => Isar.splitWords(query).expand((word) => getPhoneticCodesOfWord(word)).toSet();
