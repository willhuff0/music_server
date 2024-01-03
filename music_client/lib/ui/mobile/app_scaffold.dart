import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_client/client/client.dart';
import 'package:music_client/client/song.dart';
import 'package:music_client/ui/mobile/sync.dart';
import 'package:music_client/ui/mobile/pages/home.dart';
import 'package:music_client/ui/mobile/pages/my_music.dart';
import 'package:music_client/ui/mobile/pages/search.dart';
import 'package:music_client/ui/mobile/pages/song.dart';
import 'package:music_client/ui/widgets/song_image.dart';
import 'package:music_client/ui/widgets/ultra_gradient.dart';
import 'package:music_shared/music_shared.dart';

late AudioPlayer appPlayer;
Song? currentlyPlayingSong;
ImageProvider? currentlyPlayingImageLarge;
List<Color>? currentlyPlayingColors;

final _playStateController = StreamController<Song>.broadcast();
final playStateStream = _playStateController.stream;

AudioPreset getAudioPresetForCurrentDevice() {
  final format = Platform.isIOS || Platform.isMacOS ? CompressedAudioFormat.aac : CompressedAudioFormat.opus;

  return switch (deviceSpeed) {
    DeviceSpeed.veryFast => AudioPreset(format: format, quality: CompressedAudioQuality.high),
    DeviceSpeed.fast => AudioPreset(format: format, quality: CompressedAudioQuality.medium),
    DeviceSpeed.medium => AudioPreset(format: format, quality: CompressedAudioQuality.low),
    DeviceSpeed.slow => AudioPreset(format: format, quality: CompressedAudioQuality.low),
    _ => AudioPreset(format: format, quality: CompressedAudioQuality.low),
  };
}

Future<void> selectSong(Song song) async {
  if (syncSession != null) {
    syncSession!.load(song);
  } else {
    await preloadSong(song);
    await appPlayer.play();
  }
}

Future<void> preloadSong(Song song) async {
  final image = NetworkImage(getSongImageUrl(song.id, ImageSize.large));
  final results = await Future.wait([
    getColorsFromImage(image),
    appPlayer.setAudioSource(MusicServerAudioSource(song: song, preset: getAudioPresetForCurrentDevice())),
  ]);
  currentlyPlayingSong = song;
  currentlyPlayingImageLarge = image;
  currentlyPlayingColors = results[0] as List<Color>?;
  _playStateController.add(song);

  if (syncSession != null) {
    await appPlayer.load();
    appPlayer.play();
    await appPlayer.pause();
    await appPlayer.seek(Duration.zero);
  }
}

void play() {
  if (syncSession != null) {
    syncSession!.play();
  } else {
    appPlayer.play();
  }
}

void pause() {
  if (syncSession != null) {
    syncSession!.pause();
  } else {
    appPlayer.pause();
  }
}

void seek(Duration position, bool resumePlayAfterSeeking) async {
  if (syncSession != null) {
    await appPlayer.pause();
    await appPlayer.seek(position);

    syncSession!.seek(position);

    if (resumePlayAfterSeeking) {
      await Future.delayed(const Duration(milliseconds: 1000)); // TODO: this should not be hard coded
      syncSession!.play();
    }
  } else {
    await appPlayer.seek(position);
  }
}

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  late final StreamSubscription playStateSubscription;
  late final StreamSubscription syncSessionChangedSubscription;

  var index = 0;

  @override
  void initState() {
    appPlayer = AudioPlayer();
    //   audioLoadConfiguration: const AudioLoadConfiguration(
    //     darwinLoadControl: DarwinLoadControl(
    //       automaticallyWaitsToMinimizeStalling: false,
    //       canUseNetworkResourcesForLiveStreamingWhilePaused: true,
    //     ),
    //   ),
    // );
    playStateSubscription = playStateStream.listen((event) => setState(() {}));
    syncSessionChangedSubscription = syncSessionChanged.listen((event) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    appPlayer.dispose();
    playStateSubscription.cancel();
    syncSessionChangedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.sizeOf(context).aspectRatio > 1.0;
    return Scaffold(
      extendBody: true,
      body: AnimatedUltraGradient(
        duration: const Duration(seconds: 10),
        opacity: 0.1,
        pointSize: 750.0,
        colors: currentlyPlayingColors,
        child: IndexedStack(
          index: index,
          children: const [
            HomePage(),
            SearchPage(),
            MyMusicPage(),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (syncSession != null)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text('Connected to sync session. Latency: ${syncSession!.latency / 1000} ms'),
            ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: currentlyPlayingSong != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    child: CurrentlyPlayingFloatingWidget(
                      isLandscape: isLandscape,
                    ),
                  )
                : Container(),
          ),
          NavigationBar(
            height: 60,
            elevation: 0.0,
            backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.8),
            selectedIndex: index,
            onDestinationSelected: (value) => setState(() => index = value),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.search_outlined),
                selectedIcon: Icon(Icons.search),
                label: 'Search',
              ),
              NavigationDestination(
                icon: Icon(Icons.library_music_outlined),
                selectedIcon: Icon(Icons.library_music_rounded),
                label: 'My Music',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CurrentlyPlayingFloatingWidget extends StatefulWidget {
  final bool isLandscape;

  const CurrentlyPlayingFloatingWidget({super.key, required this.isLandscape});

  @override
  State<CurrentlyPlayingFloatingWidget> createState() => _CurrentlyPlayingFloatingWidgetState();
}

class _CurrentlyPlayingFloatingWidgetState extends State<CurrentlyPlayingFloatingWidget> {
  late final StreamSubscription _playerStateSubscription;
  late final StreamSubscription _positionSubscription;

  var position = 0.0;
  var playing = false;

  @override
  void initState() {
    _playerStateSubscription = appPlayer.playerStateStream.listen((event) => setState(() => playing = event.playing));
    _positionSubscription = appPlayer.positionStream.listen((event) => setState(() => position = clampDouble(event.inMilliseconds.toDouble() / currentlyPlayingSong!.duration.inMilliseconds, 0.0, 1.0)));
    super.initState();
  }

  @override
  void dispose() {
    _playerStateSubscription.cancel();
    _positionSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openElevation: 0.0,
      closedElevation: 0.0,
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
      middleColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 400),
      openBuilder: (context, closeContainer) {
        return SongPage(
          isLandscape: widget.isLandscape,
          onClose: () => closeContainer(),
        );
      },
      closedBuilder: (context, openContainer) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: 60.0,
            child: Stack(
              children: [
                ClipRect(
                  clipper: ProgressClipper(progress: position, direction: AxisDirection.right),
                  child: AnimatedUltraGradient(
                    duration: const Duration(seconds: 10),
                    pointSize: 150.0,
                    colors: currentlyPlayingColors!,
                    opacity: 0.5,
                  ),
                ),
                ClipRect(
                  clipper: ProgressClipper(progress: 1.0 - position, direction: AxisDirection.left),
                  child: Container(color: Theme.of(context).colorScheme.surface.withOpacity(0.3)),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Hero(
                          transitionOnUserGestures: true,
                          tag: 'song-art',
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.0),
                              image: DecorationImage(image: currentlyPlayingImageLarge!),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0, right: 18.0, top: 8.0, bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(currentlyPlayingSong!.name, style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 2.0),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Text(
                                  currentlyPlayingSong!.ownerName,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8)),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (widget.isLandscape) ...[
                      IconButton(
                        onPressed: () {
                          openContainer();
                        },
                        icon: SizedBox(
                          width: 48.0,
                          height: 48.0,
                          child: Icon(
                            Icons.open_in_full_rounded,
                            color: Colors.white.withOpacity(0.6),
                            size: 24.0,
                          ),
                        ),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      ),
                      const SizedBox(width: 12.0),
                    ],
                    IconButton(
                      onPressed: () {
                        if (playing) {
                          pause();
                        } else {
                          play();
                        }
                      },
                      icon: SizedBox(
                        width: 48.0,
                        height: 48.0,
                        child: Icon(
                          playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                          color: Colors.white.withOpacity(0.6),
                          size: 34.0,
                        ),
                      ),
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                    const SizedBox(width: 12.0),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProgressClipper extends CustomClipper<Rect> {
  final double progress;
  final AxisDirection direction;

  ProgressClipper({super.reclip, required this.progress, this.direction = AxisDirection.right});

  @override
  Rect getClip(Size size) {
    double right;
    double left;
    double top;
    double bottom;
    switch (direction) {
      case AxisDirection.right:
        left = 0.0;
        top = 0.0;
        right = size.width * progress;
        bottom = size.height;
        break;
      case AxisDirection.left:
        left = size.width * (1.0 - progress);
        top = 0.0;
        right = size.width;
        bottom = size.height;
        break;
      case AxisDirection.up:
        left = 0.0;
        top = size.height * (1.0 - progress);
        right = size.width;
        bottom = size.height;
        break;
      case AxisDirection.down:
        left = 0.0;
        top = 0.0;
        right = size.width;
        bottom = size.height * progress;
        break;
    }

    return Rect.fromLTRB(left, top, right, bottom);
  }

  @override
  bool shouldReclip(covariant ProgressClipper oldClipper) => progress != oldClipper.progress || direction != oldClipper.direction;
}
