import 'package:isar/isar.dart';

part 'transcode_operation.g.dart';

@collection
class TranscodeOperation {
  final String id;
  @utc
  final DateTime timestamp;

  String? workReceivedToken;

  String? failureMessage;

  TranscodeOperation({
    required this.id,
    required this.timestamp,
    this.workReceivedToken,
    this.failureMessage,
  });
}
