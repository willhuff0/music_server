// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:cryptography/helpers.dart';
import 'package:isar/isar.dart';
import 'package:music_server/database/transcode_operation.dart';
import 'package:music_server/database/unprocessed_song.dart';
import 'package:music_server/database/user.dart';
import 'package:music_server/music_server.dart';
import 'package:music_shared/music_shared.dart';
import 'package:path/path.dart' as p;
import 'package:music_server/stateless_server/stateless_server.dart';

import 'database/song.dart';

const transcodePresetsSimultaneously = true;
const transcodeSizesSimultaneously = true;
const keepFailedTranscodeOperationsForMilliseconds = 365 * 24 * 60 * 60 * 1000;

var _transcodeWorkerManagers = <WorkerManager>[];

void startDispatchingTranscodeWorkers(Isar isar, MusicServerPaths paths, MusicServerConfig config) async {
  // start workers
  final workerLaunchArgs = AudioTranscodeWorkerLaunchArgs(
    start: TranscodeWorker.start,
    config: config,
    paths: paths,
  );
  _transcodeWorkerManagers = await Future.wait(Iterable.generate(config.numTranscodeWorkers, (index) => WorkerManager.start(workerLaunchArgs, debugName: 'Transcode Worker $index')));

  final workReceivedToken = randomBytesAsHexString(8);
  final listenStartTime = DateTime.timestamp().millisecondsSinceEpoch;

  var nextWorkerIndex = 0;
  void onTranscodeOperationsUpdated(List<TranscodeOperation> transcodeOperations) {
    isar.writeTxnSync(() {
      for (final transcodeOperation in transcodeOperations) {
        if (transcodeOperation.workReceivedToken == workReceivedToken) continue;

        transcodeOperation.workReceivedToken = workReceivedToken;
        isar.transcodeOperations.putSync(transcodeOperation);

        _transcodeWorkerManagers[nextWorkerIndex].toIsolatePort.send(transcodeOperation);
        nextWorkerIndex++;
        if (nextWorkerIndex >= config.numTranscodeWorkers) nextWorkerIndex = 0;
      }
    }, silent: true);
  }

  // delete all failed operations older than keepFailedTranscodeOperationsForMilliseconds milliseconds
  isar.writeTxnSync(() {
    for (final oldFailedTranscodeOperation in isar.transcodeOperations.where().failedEqualToTimestampLessThan(true, listenStartTime - keepFailedTranscodeOperationsForMilliseconds).findAllSync()) {
      try {
        Directory(p.join(paths.storagePath, 'unprocessed_songs', oldFailedTranscodeOperation.songId)).deleteSync(recursive: true);
        isar.transcodeOperations.deleteSync(oldFailedTranscodeOperation.isarId);
      } catch (e) {
        print('failed to delete old failed transcode operation directory (${oldFailedTranscodeOperation.isarId}): ${oldFailedTranscodeOperation.songId}');
      }
    }
  });

  // start all not failed operations leftover from when the server last shutdown
  onTranscodeOperationsUpdated(isar.transcodeOperations.where().failedEqualToAnyTimestamp(false).findAllSync());

  // listen for new transcodeOperations and dispatch them to workers, this pulls a list of EVERY transcodeOperation each time one is added NOT GOOD
  isar.transcodeOperations.where().failedEqualToTimestampGreaterThan(false, listenStartTime).watch().listen(onTranscodeOperationsUpdated);

  stdout.writeln('Dispatching transcode workers');
}

Future<void> shutdownTranscodeWorkers() async {
  await Future.wait(_transcodeWorkerManagers.map((e) => e.shutdown()));
}

class TranscodeWorker implements Worker {
  final String? _debugName;

  final MusicServerPaths _paths;
  final Isar _isar;

  late final StreamSubscription _fromManagerStreamSubscription;

  final _operations = <String, Future<void>>{};

  TranscodeWorker._(this._debugName, this._paths, this._isar, Stream<dynamic> fromManagerStream) {
    _fromManagerStreamSubscription = fromManagerStream.listen((event) {
      if (event is TranscodeOperation) {
        _operations[event.songId] = _transcode(event).then((value) => _operations.remove(event.songId));
      }
    });
  }

  static Future<Worker> start(WorkerLaunchArgs args, Stream<dynamic> fromManagerStream, SendPort toManagerPort, {String? debugName}) async {
    if (args is! AudioTranscodeWorkerLaunchArgs) throw Exception('TranscoderWorker must be started with AudioTranscodeWorkerLaunchArgs');

    final isar = openIsarDatabaseOnIsolate(args.paths);

    return TranscodeWorker._(debugName, args.paths, isar, fromManagerStream);
  }

  Future<void> _transcode(TranscodeOperation transcodeOperation) async {
    print('[$_debugName] starting transcode operation (${transcodeOperation.isarId}): ${transcodeOperation.songId}');

    final unprocessedSong = _isar.unprocessedSongs.getByIdSync(transcodeOperation.songId);
    if (unprocessedSong == null) {
      transcodeOperation.failureMessages = List.from(transcodeOperation.failureMessages)..add('database entry does not exist');
      transcodeOperation.failed = true;
      _isar.writeTxnSync(() => _isar.transcodeOperations.putSync(transcodeOperation));
      return;
    }

    final audioInputFile = File(getUnprocessedSongAudioInputFilePath(_paths, unprocessedSong.id, unprocessedSong.fileExtension));
    if (!audioInputFile.existsSync()) {
      transcodeOperation.failureMessages = List.from(transcodeOperation.failureMessages)..add('audio input file does not exist');
      transcodeOperation.failed = true;
      _isar.writeTxnSync(() => _isar.transcodeOperations.putSync(transcodeOperation));
      return;
    }

    final imageInputFile = File(getUnprocessedSongImageInputFilePath(_paths, unprocessedSong.id, unprocessedSong.imageFileExtension ?? 'null'));
    if (!audioInputFile.existsSync()) {
      transcodeOperation.failureMessages = List.from(transcodeOperation.failureMessages)..add('audio input file does not exist');
      transcodeOperation.failed = true;
      _isar.writeTxnSync(() => _isar.transcodeOperations.putSync(transcodeOperation));
      return;
    }

    final outputDir = getSongStorageDir(_paths, unprocessedSong.id);

    final presets = [
      AudioPreset(format: CompressedAudioFormat.opus, quality: CompressedAudioQuality.low),
      AudioPreset(format: CompressedAudioFormat.opus, quality: CompressedAudioQuality.medium),
      AudioPreset(format: CompressedAudioFormat.opus, quality: CompressedAudioQuality.high),
      AudioPreset(format: CompressedAudioFormat.aac, quality: CompressedAudioQuality.low),
      AudioPreset(format: CompressedAudioFormat.aac, quality: CompressedAudioQuality.medium),
      AudioPreset(format: CompressedAudioFormat.aac, quality: CompressedAudioQuality.high),
    ];

    final sizes = ImageSize.values;

    final processResult = await Future.wait([
      processAudio(
        paths: _paths,
        inputFile: audioInputFile.path,
        outputDir: outputDir,
        presets: presets,
      ),
      processImage(
        paths: _paths,
        inputFile: imageInputFile.path,
        outputDir: outputDir,
        sizes: sizes,
      ),
    ]);

    var failed = false;

    final failureMessages = List<String>.from(transcodeOperation.failureMessages);

    if (processResult[0] != null) {
      failureMessages.add('failed to process audio: ${processResult[0]}');
      failed = true;
    }

    if (processResult[1] != null) {
      failureMessages.add('failed to process image: ${processResult[1]}');
      failed = true;
    }

    if (failed) {
      transcodeOperation.failureMessages = failureMessages;
      transcodeOperation.failed = true;
      _isar.writeTxnSync(() => _isar.transcodeOperations.putSync(transcodeOperation));
      await revertAll(outputDir: outputDir, presets: presets, sizes: sizes);
      return;
    }

    try {
      audioInputFile.parent.deleteSync(recursive: true);
    } catch (e) {
      transcodeOperation.failureMessages = List.from(transcodeOperation.failureMessages)..add('failed to delete input directory: $e');
      transcodeOperation.failed = true;
      _isar.writeTxnSync(() => _isar.transcodeOperations.putSync(transcodeOperation));
      await revertAll(outputDir: outputDir, presets: presets, sizes: sizes);
      return;
    }

    _isar.writeTxnSync(() {
      _isar.transcodeOperations.deleteSync(transcodeOperation.isarId);
      _isar.unprocessedSongs.deleteByIdSync(unprocessedSong.id);

      _isar.songs.putByIdSync(Song.createFromUnprocessed(unprocessedSong, _isar.users.getByIdSync(unprocessedSong.owner)!));
    });
  }

  @override
  Future<void> shutdown() async {
    await _fromManagerStreamSubscription.cancel();
    if (_operations.isNotEmpty) {
      stdout.writeln('$_debugName is waiting for ${_operations.length} operation(s) to finish');
      await Future.wait(_operations.values);
    }
    await _isar.close();
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

// Must be same as database/song.dart getSongAudioFilePath
String getAudioOutputFilePath(String dir, AudioPreset preset) => p.join(dir, 'audio', '${preset.quality.outputFileName}.${preset.format.fileType}');

// Must be same as database/song.dart getSongImageFilePath
String getImageOutputFilePath(String dir, ImageSize size) => p.join(dir, 'images', '${size.resolution}.webp');

Future<String?> processAudio({required MusicServerPaths paths, required String inputFile, required String outputDir, required List<AudioPreset> presets}) async {
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

    final loudnormStartIndex = loudnormResultString.indexOf('{', loudnormResultString.indexOf('Parsed_loudnorm_0'));
    final loudnormEndIndex = loudnormResultString.indexOf('}', loudnormStartIndex);
    final loudnormParsedResultString = loudnormResultString.substring(loudnormStartIndex, loudnormEndIndex + 1);
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
      final loudnormStep2Result = await Process.run(paths.ffmpegPath, ['-i', inputFile, '-y', '-map_metadata', '-1', '-map', '0:a', '-filter:a', 'loudnorm=linear=true:i=$target_i:lra=$target_lra:tp=$target_tp:offset=$target_offset:measured_I=$measured_i:measured_tp=$measured_tp:measured_LRA=$measured_lra:measured_thresh=$measured_thresh', intermediateInputFile]);
      if (loudnormStep2Result.exitCode != 0) return 'ffmpeg loudnorm step 2 exited with an error (${loudnormStep2Result.exitCode}): ${loudnormStep2Result.stderr}';

      // transcode with each preset
      Future<String?> processPreset(AudioPreset preset) async {
        final outputFile = getAudioOutputFilePath(outputDir, preset);

        final encodeParameters = switch (preset.format) {
          CompressedAudioFormat.opus => ['-i', intermediateInputFile, '-y', '-v', 'warning', '-progress', '-', '-codec:a', 'libopus', '-mapping_family', '0', '-b:a', (preset.quality.opuskbpsPerChannel * 1000 * inputAudioChannelCount).toString(), outputFile],
          CompressedAudioFormat.aac => ['-i', intermediateInputFile, '-y', '-v', 'warning', '-progress', '-', '-codec:a', 'libfdk_aac', '-vbr', preset.quality.aacVBRMode.toString(), outputFile],
        };
        final transcodeResult = await Process.run(paths.ffmpegPath, encodeParameters);
        if (transcodeResult.exitCode != 0) return 'ffmpeg transcode on preset $preset exited with an error (${transcodeResult.exitCode}): ${transcodeResult.stderr}';

        return null;
      }

      Future<void> revert() async {
        for (final preset in presets) {
          final outputFileObject = File(getAudioOutputFilePath(outputDir, preset));
          if (await outputFileObject.exists()) await outputFileObject.delete();
        }
      }

      await Directory(p.join(outputDir, 'audio')).create(recursive: true);

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

Future<String?> processImage({required MusicServerPaths paths, required String inputFile, required String outputDir, required List<ImageSize> sizes}) async {
  try {
    // transcode with each size
    Future<String?> processSize(ImageSize size) async {
      final outputFile = getImageOutputFilePath(outputDir, size);

      final encodeParameters = [inputFile, '-resize', '${size.resolution}^', '-gravity', 'center', '-extent', size.resolution, outputFile];

      final transcodeResult = await Process.run(paths.magickPath, encodeParameters);
      if (transcodeResult.exitCode != 0) return 'magick transcode on size $size exited with an error (${transcodeResult.exitCode}): ${transcodeResult.stderr}';

      return null;
    }

    Future<void> revert() async {
      for (final size in sizes) {
        final outputFileObject = File(getImageOutputFilePath(outputDir, size));
        if (await outputFileObject.exists()) await outputFileObject.delete();
      }
    }

    await Directory(p.join(outputDir, 'images')).create(recursive: true);

    try {
      if (transcodeSizesSimultaneously) {
        final processResultsFutures = sizes.map(processSize);
        final processResults = await Future.wait(processResultsFutures);
        for (final processResult in processResults) {
          if (processResult != null) {
            await revert();
            return processResult; // TODO: report errors for all failed processResults not just the first one
          }
        }
      } else {
        for (final size in sizes) {
          final processResult = await processSize(size);
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
  } catch (e) {
    return e.toString();
  }

  return null;
}

Future<void> revertAll({required String outputDir, required List<AudioPreset> presets, required List<ImageSize> sizes}) async {
  for (final preset in presets) {
    final outputFileObject = File(getAudioOutputFilePath(outputDir, preset));
    if (await outputFileObject.exists()) await outputFileObject.delete();
  }
  for (final size in sizes) {
    final outputFileObject = File(getImageOutputFilePath(outputDir, size));
    if (await outputFileObject.exists()) await outputFileObject.delete();
  }
}
