import 'package:isar/isar.dart';

part 'transcode_operation.g.dart';

@collection
class TranscodeOperation {
  Id isarId;

  final String songId;

  final int timestamp;

  String? workReceivedToken;

  @Index(composite: [CompositeIndex('timestamp')])
  bool failed;
  String? failureMessage;

  TranscodeOperation({
    this.isarId = Isar.autoIncrement,
    required this.songId,
    required this.timestamp,
    this.workReceivedToken,
    this.failed = false,
    this.failureMessage,
  });
}
