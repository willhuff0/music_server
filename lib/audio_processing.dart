// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cryptography/helpers.dart';
import 'package:isar/isar.dart';
import 'package:music_server/database/transcode_operation.dart';
import 'package:music_server/database/unprocessed_song.dart';
import 'package:music_server/music_server.dart';
import 'package:path/path.dart' as p;
import 'package:stateless_server/stateless_server.dart';

import 'database/song.dart';

const transcodePresetsSimultaneously = true;

void startDispatchingTranscodeWorkers(MusicServerPaths paths, MusicServerConfig config) async {
  // start workers
  final workerLaunchArgs = AudioTranscodeWorkerLaunchArgs(
    start: AudioTranscoderWorker.start,
    config: config,
    paths: paths,
  );
  final workerManagers = await Future.wait(Iterable.generate(config.numTranscodeWorkers, (index) => WorkerManager.start(workerLaunchArgs, debugName: 'Transcode Worker $index')));

  // listen for changes and dispatch work
  final workReceivedToken = randomBytesAsHexString(8);
  final db = openIsarDatabaseOnIsolate(paths);

  var nextWorkerIndex = 0;

  // This pulls every transcodeOperation each time one is added NOT GOOD
  db.transcodeOperations.where().watch().listen((transcodeOperations) {
    db.write((isar) {
      for (final transcodeOperation in transcodeOperations) {
        if (transcodeOperation.workReceivedToken == workReceivedToken) continue;
        transcodeOperation.workReceivedToken = workReceivedToken;
        isar.transcodeOperations.put(transcodeOperation);

        workerManagers[nextWorkerIndex].toIsolatePort.send(transcodeOperation);
        nextWorkerIndex++;
        if (nextWorkerIndex >= config.numTranscodeWorkers) nextWorkerIndex = 0;
      }
    });
  });
}

class AudioTranscoderWorker implements Worker {
  final MusicServerPaths _paths;
  final Isar _isar;

  late final StreamSubscription _fromManagerStreamSubscription;

  AudioTranscoderWorker._(this._paths, this._isar, Stream<dynamic> fromManagerStream) {
    _fromManagerStreamSubscription = fromManagerStream.listen((event) {
      if (event is TranscodeOperation) {
        _transcode(event);
      }
    });
  }

  static Future<Worker> start(WorkerLaunchArgs args, Stream<dynamic> fromManagerStream, {String? debugName}) async {
    if (args is! AudioTranscodeWorkerLaunchArgs) throw Exception('AudioTranscoderWorker must be started with AudioTranscodeWorkerLaunchArgs');

    final isar = openIsarDatabaseOnIsolate(args.paths);

    return AudioTranscoderWorker._(args.paths, isar, fromManagerStream);
  }

  Future<void> _transcode(TranscodeOperation transcodeOperation) async {
    _isar.write((isar) async {
      final unprocessedSong = isar.unprocessedSongs.get(transcodeOperation.id);
      if (unprocessedSong == null) {
        transcodeOperation.failureMessage = 'unprocessedSong (${transcodeOperation.id}) database entry does not exist';
        isar.transcodeOperations.put(transcodeOperation);
        return;
      }

      final inputFile = File(getUnprocessedSongInputFilePath(_paths, unprocessedSong.id, unprocessedSong.fileExtension));
      if (!inputFile.existsSync()) {
        transcodeOperation.failureMessage = 'unprocessedSong (${transcodeOperation.id}) input file does not exist';
        isar.transcodeOperations.put(transcodeOperation);
        return;
      }

      final outputDir = getSongStorageDir(_paths, unprocessedSong.id);

      final processResult = await processAudio(
        paths: _paths,
        inputFile: inputFile.path,
        outputDir: outputDir,
        presets: [
          ProcessAudioPreset(format: CompressedAudioFormat.opus, quality: CompressedAudioQuality.low),
          ProcessAudioPreset(format: CompressedAudioFormat.opus, quality: CompressedAudioQuality.medium),
          ProcessAudioPreset(format: CompressedAudioFormat.opus, quality: CompressedAudioQuality.high),
          ProcessAudioPreset(format: CompressedAudioFormat.aac, quality: CompressedAudioQuality.low),
          ProcessAudioPreset(format: CompressedAudioFormat.aac, quality: CompressedAudioQuality.medium),
          ProcessAudioPreset(format: CompressedAudioFormat.aac, quality: CompressedAudioQuality.high),
        ],
      );

      if (processResult != null) {
        transcodeOperation.failureMessage = 'unprocessedSong (${transcodeOperation.id}) failed to process: $processResult';
        isar.transcodeOperations.put(transcodeOperation);
        return;
      }

      isar.transcodeOperations.delete(transcodeOperation.id);
      isar.unprocessedSongs.delete(unprocessedSong.id);

      isar.songs.put(Song.createFromUnprocessed(unprocessedSong));
    });
  }

  @override
  Future<void> shutdown() async {
    _fromManagerStreamSubscription.cancel();
    _isar.close();
  }
}

class AudioTranscodeWorkerLaunchArgs extends WorkerLaunchArgs {
  final MusicServerPaths paths;

  AudioTranscodeWorkerLaunchArgs({
    required super.start,
    required super.config,
    required this.paths,
  });
}

enum CompressedAudioQuality {
  low(opuskbpsPerChannel: 36, aacVBRMode: 1, outputFileName: 'low'),
  medium(opuskbpsPerChannel: 52, aacVBRMode: 3, outputFileName: 'medium'),
  high(opuskbpsPerChannel: 96, aacVBRMode: 5, outputFileName: 'high');

  final int opuskbpsPerChannel;
  final int aacVBRMode;
  final String outputFileName;

  const CompressedAudioQuality({
    required this.opuskbpsPerChannel,
    required this.aacVBRMode,
    required this.outputFileName,
  });
}

enum CompressedAudioFormat {
  opus(fileExtension: '.opus'),
  aac(fileExtension: '.aac');

  final String fileExtension;

  const CompressedAudioFormat({required this.fileExtension});
}

class ProcessAudioPreset {
  final CompressedAudioFormat format;
  final CompressedAudioQuality quality;

  ProcessAudioPreset({required this.format, required this.quality});

  @override
  String toString() => '{format: $format, quality: $quality}';
}

String getOutputFilePath(String dir, ProcessAudioPreset preset) => p.join(dir, '${preset.quality.outputFileName}${preset.format.fileExtension}');

Future<String?> processAudio({required MusicServerPaths paths, required String inputFile, required String outputDir, required List<ProcessAudioPreset> presets}) async {
  try {
    // get channel count
    final ffprobeResult = await Process.run(paths.ffprobePath, ['-v', 'quiet', '-print_format', 'json', '-show_streams', '-select_streams', 'a:0', inputFile]);
    if (ffprobeResult.exitCode != 0) return 'ffprobe exited with an error (${ffprobeResult.exitCode}): ${ffprobeResult.stderr}';

    final inputAudioFileInfoString = ffprobeResult.stdout as String?;
    if (inputAudioFileInfoString == null || inputAudioFileInfoString.isEmpty) return 'ffprobe did not provide a result';

    final inputAudioFileInfo = jsonDecode(inputAudioFileInfoString) as Map<String, dynamic>?;
    if (inputAudioFileInfo == null) return 'ffprobe did not return json';

    final inputAudioStreams = inputAudioFileInfo['streams'] as List<dynamic>?;
    if (inputAudioStreams == null) return 'ffprobe found no audio streams';

    final inputAudioFirstStream = inputAudioStreams.firstOrNull as Map<String, dynamic>?;
    if (inputAudioFirstStream == null) return 'ffprobe found no audio streams';

    final inputAudioChannelCount = inputAudioFirstStream['channels'] as int?;
    if (inputAudioChannelCount == null) return 'ffprobe output was malformated: first audio stream does not contain \'channels\'';

    if (inputAudioChannelCount > 2) return 'first audio stream has more than 2 channels';

    // normalize audio
    final loudnormResult = await Process.run(paths.ffmpegPath, ['-i', inputFile, '-y', '-hide_banner', '-nostats', '-filter:a', 'loudnorm=print_format=json', '-f', 'null', 'NULL']);
    if (loudnormResult.exitCode != 0) return 'ffmpeg loudnorm exited with an error (${loudnormResult.exitCode}): ${loudnormResult.stderr}';

    final loudnormResultString = loudnormResult.stderr as String?;
    if (loudnormResultString == null || loudnormResultString.isEmpty) return 'ffmpeg loudnorm did not provide a result';

    final loudnormParsedResultString = loudnormResultString.substring(loudnormResultString.indexOf('{', loudnormResultString.indexOf('Parsed_loudnorm_0')));
    if (loudnormParsedResultString.isEmpty) return 'ffmpeg loudnorm did not provide a result or the result was malformed';

    final loudnormParsedResult = jsonDecode(loudnormParsedResultString) as Map<String, dynamic>?;
    if (loudnormParsedResult == null) return 'ffmpeg loudnorm did not provide a result or the result was malformed';

    final measured_i = loudnormParsedResult['input_i'] as String?;
    if (measured_i == null || measured_i.isEmpty) return 'ffmpeg loudnorm result was malformed, input_i was null or empty';

    final measured_tp = loudnormParsedResult['input_tp'] as String?;
    if (measured_tp == null || measured_tp.isEmpty) return 'ffmpeg loudnorm result was malformed, input_tp was null or empty';

    final measured_lra = loudnormParsedResult['input_lra'] as String?;
    if (measured_lra == null || measured_lra.isEmpty) return 'ffmpeg loudnorm result was malformed, input_lra was null or empty';

    final measured_thresh = loudnormParsedResult['input_thresh'] as String?;
    if (measured_thresh == null || measured_thresh.isEmpty) return 'ffmpeg loudnorm result was malformed, input_thresh was null or empty';

    const target_i = '-14.0';
    const target_tp = '-2.0';
    const target_lra = '7.0';
    const target_offset = '0.0';

    final intermediateInputFile = '${p.withoutExtension(inputFile)}_normalized${p.extension(inputFile)}';
    try {
      final loudnormStep2Result = await Process.run(paths.ffmpegPath, ['-i', inputFile, '-y', '-filter:a', 'loudnorm=linear=true:i=$target_i:lra=$target_lra:tp=$target_tp:offset=$target_offset:measured_I=$measured_i:measured_tp=$measured_tp:measured_LRA=$measured_lra:measured_thresh=$measured_thresh', intermediateInputFile]);
      if (loudnormStep2Result.exitCode != 0) return 'ffmpeg loudnorm step 2 exited with an error (${loudnormStep2Result.exitCode}): ${loudnormStep2Result.stderr}';

      // transcode with each preset
      Future<String?> processPreset(ProcessAudioPreset preset) async {
        final outputFile = getOutputFilePath(outputDir, preset);

        final encodeParameters = switch (preset.format) {
          CompressedAudioFormat.opus => ['-i', intermediateInputFile, '-y', '-v', 'quiet', '-progress', '-', '-codec:a', 'libopus', '-mapping_family', '0', '-b:a', (preset.quality.opuskbpsPerChannel * 1000 * inputAudioChannelCount).toString(), outputFile],
          CompressedAudioFormat.aac => ['-i', intermediateInputFile, '-y', '-v', 'quiet', '-progress', '-', '-codec:a', 'libfdk_aac', '-vbr', preset.quality.aacVBRMode.toString(), outputFile],
        };
        final transcodeResult = await Process.run(paths.ffmpegPath, encodeParameters);
        if (transcodeResult.exitCode != 0) return 'ffmpeg transcode on preset $preset exited with an error (${transcodeResult.exitCode}): ${transcodeResult.stderr}';

        return null;
      }

      Future<void> revert() async {
        for (final preset in presets) {
          final outputFileObject = File(getOutputFilePath(outputDir, preset));
          if (await outputFileObject.exists()) await outputFileObject.delete();
        }
      }

      try {
        if (transcodePresetsSimultaneously) {
          final processResultsFutures = presets.map(processPreset);
          final processResults = await Future.wait(processResultsFutures);
          for (final processResult in processResults) {
            if (processResult != null) {
              await revert();
              return processResult;
            }
          }
        } else {
          for (final preset in presets) {
            final processResult = await processPreset(preset);
            if (processResult != null) {
              await revert();
              return processResult;
            }
          }
        }
      } catch (e) {
        await revert();
        return e.toString();
      }
    } finally {
      final intermediateInputFileObject = File(intermediateInputFile);
      if (await intermediateInputFileObject.exists()) await intermediateInputFileObject.delete();
    }
  } catch (e) {
    return e.toString();
  }

  return null;
}
