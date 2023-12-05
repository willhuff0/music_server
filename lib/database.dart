import 'dart:io';

import 'package:isar/isar.dart';
import 'package:music_server/database/user.dart';
import 'package:path/path.dart' as p;

export 'database/user.dart';
export 'database/song.dart';

Future<Isar> openIsarDatabaseOnIsolate({bool inspector = false}) async {
  String path;
  if (const bool.fromEnvironment("dart.vm.product")) {
    path = p.dirname(Platform.resolvedExecutable);
  } else {
    path = Directory.current.path;
  }
  path = p.join(path, 'database');
  await Directory(path).create(recursive: true);

  final isar = await Isar.openAsync(
    schemas: [
      UserSchema,
      UserActivitySchema,
    ],
    directory: path,
    inspector: inspector,
  );

  return isar;
}
