import 'package:isar/isar.dart';

part 'user_activity.g.dart';

@Collection(accessor: 'userActivities')
class UserActivity {
  Id isarId;

  @Index()
  final String userId;

  @Enumerated(EnumType.ordinal)
  final UserActivityType type;
  final DateTime timestamp;

  UserActivity({
    this.isarId = Isar.autoIncrement,
    required this.userId,
    required this.type,
    required this.timestamp,
  });

  static UserActivity now(String userId, UserActivityType type) => UserActivity(userId: userId, type: type, timestamp: DateTime.timestamp());
}

enum UserActivityType {
  createUserAndStartSession,
  startSession,
  createSong,
}
