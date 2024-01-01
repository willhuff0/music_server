import 'package:isar/isar.dart';

part 'sync_session.g.dart';

@collection
class SyncSession {
  Id isarId;

  @Index(unique: true)
  final String userId;

  List<String> authorizedClients;

  int? port;

  @Index()
  bool workReceived;

  SyncSession({
    this.isarId = Isar.autoIncrement,
    required this.userId,
    required this.authorizedClients,
    this.port,
    this.workReceived = false,
  });
}
