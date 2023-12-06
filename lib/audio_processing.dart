import 'package:stateless_server/stateless_server.dart';

import 'database/song.dart';

class AudioTranscoderWorker implements Worker {
  AudioTranscoderWorker._();

  static Future<Worker> start(WorkerLaunchArgs args, {String? debugName}) async {
    return AudioTranscoderWorker._();
  }

  @override
  Future<void> shutdown() async {}
}

void addSongToTranscodeQueue(Song song) {}
