import 'package:isar/isar.dart';

part 'transcode_operation.g.dart';

@collection
class TranscodeOperation {
  Id isarId;

  @Index(unique: true)
  final String songId;

  final int timestamp;

  String? workReceivedToken;

  @Index(composite: [CompositeIndex('timestamp')])
  bool failed;
  List<String> failureMessages;

  TranscodeOperation({
    this.isarId = Isar.autoIncrement,
    required this.songId,
    required this.timestamp,
    this.workReceivedToken,
    this.failed = false,
    this.failureMessages = const [],
  });
}
