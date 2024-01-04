# Technical Documentation

## Music Service

A full stack music streaming service built from scratch.

I created this project mostly for fun. Later, I adapted it to solve a specific problem I was having. I wanted a way to synchronize speakers in my home.

I designed:
- a worker system to manage threads
- an http server using those workers
- a stateless session system

### Open source projects used

#### Server

- Dart (https://github.com/dart-lang)
- Isar (https://github.com/isar/isar): Document database
- dart_phonetics (https://github.com/raycardillo/dart_phonetics): Provides the double metaphone algorithm
- Shelf (https://github.com/dart-lang/shelf): Web Server Middleware for Dart
- Cryptography (https://github.com/dint-dev/cryptography): Provides argon2id, Hmac and sha256 implementations
- dart-uuid (https://github.com/Daegalus/dart-uuid): Uuid generation

#### Client

- Flutter (https://github.com/flutter/flutter): UI toolkit
- just_audio (https://github.com/ryanheise/just_audio): Audio player for Flutter
- flutter_secure_storage (https://github.com/mogol/flutter_secure_storage): Access to iOS keychain etc
- dyn_mouse_scroll (https://github.com/alesimula/dyn_mouse_scroll): Fixes an issue with scrolling in Flutter
- infinite_scroll_pagination (https://github.com/EdsonBueno/infinite_scroll_pagination): Drop in pagination for scrolling views
- desktop_drop (https://github.com/MixinNetwork/flutter-plugins/tree/main/packages/desktop_drop): Drag and drop files into Flutter app
- synchronized (https://github.com/tekartik/synchronized.dart): Provides locking for async dart code
- flutter_file_picker (https://github.com/miguelpruivo/flutter_file_picker): File picker on desktop

### Stateless Server

#### Worker

The class mainly deals with Dart's threading system. To avoid common multithreading related bugs, Dart doesn't allow shared memory between threads (yet). Which is why, I assume, they call threads Isolates. To exchange information messages have to be sent over ports, which can be a pain, and is why I keep all of that logic out of mind in these classes.

```dart
class WorkerManager {
  final Isolate _isolate;
  final Stream<dynamic> fromIsolateStream;
  final SendPort toIsolatePort;

  late final StreamSubscription _fromIsolateSubscription;

  WorkerManager._(this._isolate, this.fromIsolateStream, this.toIsolatePort) {
    _fromIsolateSubscription = fromIsolateStream.listen((message) {});
  }

  static Future<WorkerManager> start(WorkerLaunchArgs args, {String? debugName}) async {
    final fromIsolatePort = ReceivePort();
    final fromIsolatePortBroadcast = fromIsolatePort.asBroadcastStream();
    final isolate = await Isolate.spawn<(SendPort, WorkerLaunchArgs, String?)>(
      (message) => WorkerIsolate.spawn(message.$1, message.$2, debugName: message.$3),
      (fromIsolatePort.sendPort, args, debugName),
      debugName: debugName,
    );
    final toIsolatePort = await fromIsolatePortBroadcast.first;
    return WorkerManager._(isolate, fromIsolatePortBroadcast, toIsolatePort);
  }

  Future<void> shutdown() async {
    toIsolatePort.send('shutdown');
  }
}

class WorkerIsolate {
  final Worker _worker;
  final Stream<dynamic> _fromManagerStream;
  final SendPort _toManagerPort;

  late final StreamSubscription _fromManagerSubscription;

  WorkerIsolate._(this._worker, this._fromManagerStream, this._toManagerPort) {
    _fromManagerSubscription = _fromManagerStream.listen((message) {
      switch (message) {
        case 'shutdown':
          _shutdown();
          break;
      }
    });
  }

  static Future<WorkerIsolate> spawn(SendPort toManagerPort, WorkerLaunchArgs args, {String? debugName}) async {
    final fromManagerPort = ReceivePort();
    toManagerPort.send(fromManagerPort.sendPort);
    final fromManagerStream = fromManagerPort.asBroadcastStream();

    final worker = await args.start(args, fromManagerStream, toManagerPort, debugName: debugName);

    return WorkerIsolate._(worker, fromManagerStream, toManagerPort);
  }

  Future<void> _shutdown() async {
    _worker.shutdown();
    _fromManagerSubscription.cancel();
  }
}

abstract interface class Worker {
  Future<void> shutdown();
}

class WorkerLaunchArgs {
  Future<Worker> Function(WorkerLaunchArgs args, Stream<dynamic> fromManagerStream, SendPort toManagerPort, {String? debugName}) start;
  final ServerConfig config;

  WorkerLaunchArgs({required this.start, required this.config});
}

class WorkerLaunchArgsWithAuthentication extends WorkerLaunchArgs {
  final Uint8List privateKey;

  WorkerLaunchArgsWithAuthentication({required super.start, required super.config, required this.privateKey});
}

```


##### APIWorker

This class implements the Worker interface and allows me to provide list of CustomHandler objects, which take a route and a closure to be executed when an http request is received. I extend CustomHandlerBase to CustomHandlerAuthRequired which inserts some extra code before calling the provided closure to automatically handle authentication tokens. Since the closure may be executed on some arbitrary thread, CustomThreadData is passed to allow access to some thread bound state, such as the Isar database reference.

```dart
class APIWorker implements Worker {
  final APIWorkerLaunchArgs _args;
  final HttpServer _server;
  final Router _router;
  final CustomThreadData _threadData;

  APIWorker._(this._server, this._router, this._threadData, this._args) {
    for (final customHandler in _args.customHandlers) {
      addCustomHandler(customHandler);
    }
  }

  static Future<Worker> start(WorkerLaunchArgs args, Stream<dynamic> fromManagerStream, SendPort toManagerPort, {String? debugName}) async {
    if (args is! APIWorkerLaunchArgs) throw Exception('APIWorker must be started with APIWorkerLaunchArgs');

    final threadData = await args.createThreadData();

    final router = Router();
    final handler = Pipeline().addMiddleware(logRequests(logger: debugName != null ? (message, isError) => print('[$debugName] $message') : null)).addHandler(router.call);
    final server = await serve(handler, args.config.address, args.config.port, shared: true);

    return APIWorker._(server, router, threadData, args);
  }

  void addCustomHandler(CustomHandlerBase customHandler) => _router.all(customHandler.path, customHandler.createHandler(_threadData));

  @override
  Future shutdown() async {
    await _server.close();
    _args.onClose(_threadData);
  }
}

abstract class CustomHandlerBase<TThreadData extends CustomThreadData> {
  final String path;

  CustomHandlerBase({required this.path});

  FutureOr<Response> Function(Request request) createHandler(TThreadData threadData);
}

class CustomHandler<TThreadData extends CustomThreadData> extends CustomHandlerBase<TThreadData> {
  final FutureOr<Response> Function(Request request, TThreadData threadData) handle;

  CustomHandler({required super.path, required this.handle});

  @override
  FutureOr<Response> Function(Request request) createHandler(TThreadData threadData) => (request) => handle(request, threadData);
}

class CustomHandlerAuthRequired<TClaims extends IdentityTokenClaims, TThreadData extends CustomThreadDataWithAuth<TClaims>> extends CustomHandlerBase<TThreadData> {
  final FutureOr<Response> Function(Request request, TThreadData threadData, IdentityToken<TClaims> identityToken) handle;

  CustomHandlerAuthRequired({required super.path, required this.handle});

  @override
  FutureOr<Response> Function(Request request) createHandler(TThreadData threadData) => (request) {
        final encodedToken = request.headers['token'];
        if (encodedToken == null) return Response.forbidden('');
        final identityToken = threadData.identityTokenAuthority.verifyAndDecodeToken(encodedToken);
        if (identityToken == null) return Response.forbidden('');

        return handle(request, threadData, identityToken);
      };
}

abstract class CustomThreadData {}

class CustomThreadDataWithAuth<TClaims extends IdentityTokenClaims> extends CustomThreadData {
  final IdentityTokenAuthority<TClaims> identityTokenAuthority;

  CustomThreadDataWithAuth({required this.identityTokenAuthority});
}

class APIWorkerLaunchArgs extends WorkerLaunchArgs {
  final FutureOr<CustomThreadData> Function() createThreadData;
  final List<CustomHandlerBase> customHandlers;
  final FutureOr<void> Function(CustomThreadData threadData) onClose;

  APIWorkerLaunchArgs({
    required super.config,
    required this.createThreadData,
    required this.onClose,
    this.customHandlers = const [],
  }) : super(start: APIWorker.start);
}
```

List of handlers used in music_server (note some functional programming aspects, the handle variable takes a Function object):

```dart
final musicServerCustomHandlers = [
  CustomHandler(path: '/status', handle: statusHandler),
  CustomHandler(path: '/speedTest/<size>', handle: speedTestHandler),

  // Auth
  CustomHandler(path: '/auth/createUser', handle: authCreateUserHandler),
  CustomHandler(path: '/auth/startSession', handle: authStartSessionHandler),
  CustomHandlerAuthRequired(path: '/auth/getName', handle: authGetNameHandler),
  CustomHandlerAuthRequired(path: '/auth/searchUser', handle: authSearchUserHandler),

  // Song
  CustomHandlerAuthRequired(path: '/song/create', handle: songCreateHandler),
  CustomHandlerAuthRequired(path: '/song/uploadData', handle: songUploadDataHandler),
  CustomHandlerAuthRequired(path: '/song/uploadImage', handle: songUploadImageHandler),
  CustomHandlerAuthRequired(path: '/song/uploadDone', handle: songUploadDoneHandler),
  CustomHandlerAuthRequired(path: '/song/getData', handle: songGetDataHandler),
  CustomHandler(path: '/song/getImage/<songId>/<size>', handle: songGetImageHandler),
  CustomHandlerAuthRequired(path: '/song/search', handle: songSearchHandler),
  CustomHandlerAuthRequired(path: '/song/filter', handle: songFilterHandler),
  CustomHandlerAuthRequired(path: '/song/popular', handle: songPopularHandler),

  // Sync
  CustomHandlerAuthRequired(path: '/sync/startOrJoinSession', handle: syncStartOrJoinSessionHandler),
];
```

### Sessions

Each time the server starts, it generates a new random key to use with Hmac. If this server was deployed for real, this key should be rotated at runtime, and destroyed properly so it doesn't sit in memory for too long waiting to be garbage collected. With that said, I'm sure there is plenty of other security vulnerabilities dotted around.

```dart
final privateKey = generateSecureRandomKey(config.tokenKeyLength);
```

The IdentityToken is analogous to a JWT (JSON Web Token). It is generated and signed by the server then stored on the client. On each API request, inside CustomHandlerAuthRequired, the tokens signature is verified to be authentic by comparing it to a freshly generated one based on the token's data. Tokens cannot be modified or forged as the signature would no longer match the token's data. In order to generate a valid signature, one would need to know the privateKey ^above.

Example of an IdentityToken and its signature:

```json
{
    "uid": "018cd0d2-a69b-7bbe-a056-650ece3dcfb7",
    "name": "Will",
    "time": "2023-12-20T00:29:18.997310Z",
    "ip": "127.0.0.1",
    "agent": "PostmanRuntime/7.36.0",
    "key": <random bytes>,
    "claims": {
        "tier": 1
    }
}
```

```
0BClJqZtsVacCRHuf3+3MZIzoerHRJz75+5zdfxCRkY=
```

Passwords are hashed with Argon2 which is future proof against quantum computers.

```dart
final _passwordHashingAlgorithm = Argon2id(
  parallelism: 1,
  memory: 19456,
  iterations: 2,
  hashLength: 32,
);
```
```dart
@embedded
class HashedUserPassword {
  final List<byte> nonce;
  final List<byte> hash;

  HashedUserPassword({
    this.nonce = const [],
    this.hash = const [],
  });

  static Future<HashedUserPassword> createNew(String password) async {
    final passwordNonce = generateSecureRandomKey(4);
    final passwordHash = await _passwordHashingAlgorithm.deriveKeyFromPassword(password: password, nonce: passwordNonce).then((value) => value.extractBytes());
    return HashedUserPassword(hash: passwordHash, nonce: passwordNonce);
  }

  Future<bool> checkPasswordMatch(String password) async {
    final passwordHash = await _passwordHashingAlgorithm.deriveKeyFromPassword(password: password, nonce: nonce).then((value) => value.extractBytes());
    return ListEquality().equals(passwordHash, hash);
  }
}
```

#### Transcoding

A TranscodeWorker will acquire a new TranscodeOperation, which are inserted into the database when a song finishes uploading, and begin processing the audio

My audio transcoding process is very procedural, the function mainly consists of verification and error checking. I use ffmpeg's loudnorm filter to normalize the audio so that one song isn't louder than any others. Then I transcode to three different qualities with both libopus and libfdk_aac (aac wouldn't be necessary if apple used common standards, which would save more than half of the storage space since aac files are larger for the same quality - just to point out my frustrations).

```dart
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
```

Image processing is similar and uses ImageMagick.

```dart
final encodeParameters = [inputFile, '-resize', '${size.resolution}^', '-gravity', 'center', '-extent', size.resolution, outputFile];

final transcodeResult = await Process.run(paths.magickPath, encodeParameters);
```

#### Search

This snippet from songSearchHandler preforms a query on the stored and indexed phonetic codes of each song's name. Isar generates functions with names based on the variables in the data model, ie in "sortByPopularityDesc", popularity is a double stored in each song document. Searching on indexes is much faster than filtering each document, and using phonetic codes allows that search to still be fuzzy (such as allowing a spelling error in a song title).

```dart
final queryPhonetics = getPhoneticCodesOfQuery(queryString);
final searchResults = threadData.isar.songs.where().anyOf(queryPhonetics, (q, element) => q.namePhoneticsElementEqualTo(element)).sortByPopularityDesc().offset(start).limit(limit).findAllSync();

return Response.ok(jsonEncode(searchResults.map((song) => song.toJson()).toList()));
```

#### Sync Session

Here's a tongue twister: SyncSessionWorkers manage web socket servers that mediate sync sessions.

Sync sessions allow multiple clients signed in as the same user to play music at the same time, over the LAN this can be quite precise.

The server serves mainly as a relay to allow clients to send messages to each other. But some important logic is preformed in this case statement inside _onRequest. The 'effective' time is in the future, it is the exact time the clients should begin playback.

```dart
case 'callTimeSensitive':
  final call = json['call'];
  final effective = DateTime.timestamp().add(Duration(milliseconds: 1000)).microsecondsSinceEpoch;
  final response = jsonEncode({
    'method': 'callTimeSensitive',
    'call': call,
    'effective': effective,
  });
  for (final client in clients) {
    client.sink.add(response);
  }
  break;
```

Client side, the difference between the server and client device's clocks is calculated.

```dart
void _timeResponse(dynamic json) {
    final clientReceiveTimestamp = DateTime.timestamp();

    if (_clientSendTimestamp == null) return;

    final serverSentTimestamp = DateTime.fromMicrosecondsSinceEpoch(json['sent']);

    final roundTripDuration = clientReceiveTimestamp.difference(_clientSendTimestamp!);
    final fromServerDuration = clientReceiveTimestamp.difference(serverSentTimestamp);

    latency = roundTripDuration.inMicroseconds ~/ 2;
    difference = fromServerDuration.inMicroseconds - latency;

    syncSessionChangedController.add(syncSession);
  }
```

The difference value is then used determine how long the client should wait before beginning playback.

```dart
void _playResponse(dynamic json) async {
    _clientSendTimestamp = null;
    final effective = DateTime.fromMicrosecondsSinceEpoch(json['effective'] + difference);
    final microsecondsUntilCall = effective.difference(DateTime.timestamp()).inMicroseconds;
    sleep(Duration(microseconds: microsecondsUntilCall));
    await appPlayer.play();
  }
```


### Mobile and Web Clients

#### Visuals

This is the main logic of a gradient shader I use as a background nearly everywhere. All of the arrays contain 4 elements. Each fragment simply measures its distance to each of the points and adds that points color based on the distance.

```glsl
float falloff(float dist, float size) {
    return 1 - clamp(dist / size, 0.0, 1.0);
}

void main() {
    vec2 fragPosition = FlutterFragCoord().xy;

    vec4 totalColor = vec4(0.0);
    for(int i = 0; i < numPoints; i++) {
        vec2 pointPosition = uPointPositions[i];
        float pointSize = uPointSizes[i];
        vec3 pointColor = uPointColors[i];

        float dist = distance(pointPosition, fragPosition);
        float intensity = falloff(dist, pointSize);

        totalColor += vec4(pointColor, 1.0) * intensity;
    }
    
    fragColor = totalColor * outputIntensity;
}
```

On the Dart side, I generate random positions with a simple poisson disk sample

```dart
/// Simple Poisson Disk Sampling. Generates random points until count valid points are found. Fails after 100 unsuccessful samples.
List<(double x, double y)> poissonDiskSample({required int count, required double radius, required double sizeX, required double sizeY}) {
  final points = [(_random.nextDouble() * sizeX, _random.nextDouble() * sizeY)];

  var i = 1;
  for (var k = 0; k < 100; k++) {
    final sample = (_random.nextDouble() * sizeX, _random.nextDouble() * sizeY);

    var valid = true;
    for (final point in points) {
      final difference = (sample.$1 - point.$1, sample.$2 - point.$2);
      final distance = sqrt(difference.$1 * difference.$1 + difference.$2 * difference.$2);

      if (distance < radius) {
        valid = false;
        break;
      }
    }
    if (valid) {
      points.add(sample);
      i++;
      if (i >= count) break;
    }
  }

  // If no more points can be generated, force random sample
  if (points.length < count) points.addAll(List.generate(count - points.length, (index) => (_random.nextDouble() * sizeX, _random.nextDouble() * sizeY)));

  return points;
}
```

Then I take two samples and interpolate between them

```dart
final pointPositions = lerpPositions(pointPositionsA!, pointPositionsB!, animationController.value);
```

Result:

<img src="gradient.png" height="300">