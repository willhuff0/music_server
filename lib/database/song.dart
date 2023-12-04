import 'package:isar/isar.dart';

part 'song.g.dart';

@collection
class Song {
  final int id;

  final String name;
  final String description;

  final int numPlays;

  Song({
    required this.id,
    required this.name,
    required this.description,
    this.numPlays = 0,
  });
}
