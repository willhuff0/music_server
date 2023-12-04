import 'dart:io';

import 'package:isar/isar.dart';
import 'package:music_server/database/user.dart';
import 'package:path/path.dart' as p;

Future<Isar> openIsarDatabaseOnIsolate() async {
  String path;
  if (const bool.fromEnvironment("dart.vm.product")) {
    path = p.dirname(Platform.resolvedExecutable);
  } else {
    path = Directory.current.path;
  }
  path = p.join(path, 'database');

  final isar = await Isar.openAsync(
    schemas: [
      UserSchema,
      UserActivitySchema,
    ],
    directory: path,
  );

  return isar;
}
