import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_client/ui/widgets/ultra_gradient.dart';

class SongDisplay extends StatefulWidget {
  final String? id;
  final String name;
  final String ownerName;
  final String description;
  final ImageProvider? image;
  final List<Color>? colors;
  final Duration duration;
  final AudioPlayer audioPlayer;
  final void Function()? onPlay;
  final void Function()? onPause;
  final void Function(Duration duration, bool resumePlayAfterSeeking)? onSeek;
  final bool isLandscape;

  const SongDisplay({
    super.key,
    this.id,
    required this.name,
    required this.ownerName,
    required this.description,
    required this.image,
    required this.colors,
    required this.duration,
    required this.audioPlayer,
    this.onPlay,
    this.onPause,
    this.onSeek,
    this.isLandscape = false,
  });

  @override
  State<SongDisplay> createState() => _SongDisplayState();
}

class _SongDisplayState extends State<SongDisplay> {
  late final StreamSubscription _playerStateSubscription;
  late final StreamSubscription _positionSubscription;
  late final StreamSubscription _bufferedPositionSubscription;

  var position = 0.0;
  var bufferedPosition = 0.0;
  var dragging = false;
  var playing = false;

  @override
  void initState() {
    _playerStateSubscription = widget.audioPlayer.playerStateStream.listen((event) => setState(() => playing = event.playing));
    _positionSubscription = widget.audioPlayer.positionStream.listen((event) {
      if (!dragging) setState(() => position = clampDouble(event.inMilliseconds.toDouble() / widget.duration.inMilliseconds, 0.0, 1.0));
    });
    _bufferedPositionSubscription = widget.audioPlayer.bufferedPositionStream.listen((event) {
      setState(() => bufferedPosition = clampDouble(event.inMilliseconds.toDouble() / widget.duration.inMilliseconds, 0.0, 1.0));
    });
    super.initState();
  }

  @override
  void dispose() {
    _playerStateSubscription.cancel();
    _positionSubscription.cancel();
    _bufferedPositionSubscription.cancel();
    super.dispose();
  }

  void pressPlayPauseButton() {
    if (playing) {
      if (widget.onPause != null) {
        widget.onPause!();
      } else {
        widget.audioPlayer.pause();
      }
    } else {
      if (widget.onPlay != null) {
        widget.onPlay!();
      } else {
        widget.audioPlayer.play();
      }
    }
  }

  void pressSkipForwardButton() {}

  void pressSkipBackwardButton() {
    seek(0.0);
  }

  void seek(double value) {
    position = value;
    if (widget.onSeek != null) {
      widget.onSeek!(Duration(milliseconds: (position * widget.duration.inMilliseconds).round()), playing);
    } else {
      widget.audioPlayer.seek(Duration(milliseconds: (position * widget.duration.inMilliseconds).round()));
    }
    dragging = false;
  }

  @override
  Widget build(BuildContext context) {
    final art = AspectRatio(
      aspectRatio: 1.0,
      child: Hero(
        transitionOnUserGestures: true,
        tag: 'song-art',
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            image: widget.image != null ? DecorationImage(image: widget.image!) : null,
            color: widget.image == null ? Colors.black : null,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: AnimatedUltraGradient(
        duration: const Duration(seconds: 10),
        pointSize: 500.0,
        colors: widget.colors,
        child: Align(
          alignment: const Alignment(0.0, 0.2),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.isLandscape
                    ? Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: art,
                        ),
                      )
                    : art,
                const SizedBox(height: 48.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(widget.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 4.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    widget.description,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.normal),
                    textAlign: TextAlign.justify,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 24.0),
                MediaQuery(
                  data: const MediaQueryData(
                    navigationMode: NavigationMode.directional,
                  ),
                  child: SliderTheme(
                    data: const SliderThemeData(
                      trackShape: CustomSliderTrackShape(),
                      thumbShape: CustomSliderThumbShape(enabledThumbRadius: 7.0),
                      overlayShape: CustomSliderOverlayShape(overlayRadius: 10.0),
                    ),
                    child: Slider(
                      value: position,
                      activeColor: Colors.white.withOpacity(0.7),
                      inactiveColor: Colors.grey.shade900.withOpacity(0.7),
                      thumbColor: Colors.white,
                      secondaryTrackValue: bufferedPosition,
                      secondaryActiveColor: Colors.grey.shade700.withOpacity(0.2),
                      onChanged: (value) => setState(() => position = value),
                      onChangeStart: (value) => dragging = true,
                      onChangeEnd: seek,
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 40.0,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          durationToString(Duration(milliseconds: (position * widget.duration.inMilliseconds).round())),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    SizedBox(
                      width: 40.0,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          durationToString(widget.duration),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 0.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: pressSkipBackwardButton,
                      icon: Icon(Icons.skip_previous_rounded, color: Colors.white.withOpacity(0.7)),
                      iconSize: 48.0,
                    ),
                    const SizedBox(width: 14.0),
                    IconButton(
                      onPressed: pressPlayPauseButton,
                      icon: Icon(playing ? Icons.pause_rounded : Icons.play_arrow_rounded, color: Colors.white.withOpacity(0.7)),
                      iconSize: 68.0,
                    ),
                    const SizedBox(width: 14.0),
                    IconButton(
                      onPressed: pressSkipForwardButton,
                      icon: Icon(Icons.skip_next_rounded, color: Colors.white.withOpacity(0.7)),
                      iconSize: 48.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String durationToString(Duration duration) {
  String minutes = duration.inMinutes.remainder(60).abs().toString();
  String twoDigitSeconds = duration.inSeconds.remainder(60).abs().toString().padLeft(2, '0');
  return "$minutes:$twoDigitSeconds";
}

class CustomSliderTrackShape extends RoundedRectSliderTrackShape {
  const CustomSliderTrackShape();
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class CustomSliderThumbShape extends RoundSliderThumbShape {
  const CustomSliderThumbShape({super.enabledThumbRadius = 10.0});

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    super.paint(context, center.translate(-(value - 0.5) / 0.5 * enabledThumbRadius, 0.0), activationAnimation: activationAnimation, enableAnimation: enableAnimation, isDiscrete: isDiscrete, labelPainter: labelPainter, parentBox: parentBox, sliderTheme: sliderTheme, textDirection: textDirection, value: value, textScaleFactor: textScaleFactor, sizeWithOverflow: sizeWithOverflow);
  }
}

class CustomSliderOverlayShape extends RoundSliderOverlayShape {
  final double thumbRadius;
  const CustomSliderOverlayShape({this.thumbRadius = 10.0, super.overlayRadius});

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    super.paint(context, center.translate(-(value - 0.5) / 0.5 * thumbRadius, 0.0), activationAnimation: activationAnimation, enableAnimation: enableAnimation, isDiscrete: isDiscrete, labelPainter: labelPainter, parentBox: parentBox, sliderTheme: sliderTheme, textDirection: textDirection, value: value, textScaleFactor: textScaleFactor, sizeWithOverflow: sizeWithOverflow);
  }
}
