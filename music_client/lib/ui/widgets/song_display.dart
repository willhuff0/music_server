import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_client/ui/widgets/ultra_gradient.dart';

class SongDisplay extends StatefulWidget {
  final String name;
  final String description;
  final ImageProvider? image;
  final List<Color>? colors;
  final AudioPlayer audioPlayer;

  const SongDisplay({super.key, required this.name, required this.description, required this.image, required this.colors, required this.audioPlayer});

  @override
  State<SongDisplay> createState() => _SongDisplayState();
}

class _SongDisplayState extends State<SongDisplay> {
  late final StreamSubscription _playerStateSubscription;
  late final StreamSubscription _durationSubscription;
  late final StreamSubscription _positionSubscription;

  Duration? duration;
  var position = 0.0;
  var dragging = false;
  var playing = false;

  @override
  void initState() {
    _playerStateSubscription = widget.audioPlayer.playerStateStream.listen((event) => setState(() => playing = event.playing));
    _durationSubscription = widget.audioPlayer.durationStream.listen((event) => setState(() => duration = event));
    _positionSubscription = widget.audioPlayer.positionStream.listen((event) {
      if (!dragging) setState(() => position = duration != null ? event.inMilliseconds.toDouble() / duration!.inMilliseconds.toDouble() : 0.0);
    });
    super.initState();
  }

  @override
  void dispose() {
    _playerStateSubscription.cancel();
    _durationSubscription.cancel();
    _positionSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedUltraGradient(
      duration: const Duration(seconds: 10),
      pointSize: 600.0,
      colors: widget.colors,
      child: Align(
        alignment: const Alignment(0.0, -0.3),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    image: widget.image != null ? DecorationImage(image: widget.image!) : null,
                    color: widget.image == null ? Colors.black : null,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(widget.name, style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 18.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  widget.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 36.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.fast_rewind_rounded, color: Colors.white.withOpacity(0.7)),
                    iconSize: 60.0,
                  ),
                  const SizedBox(width: 8.0),
                  IconButton(
                    onPressed: () {
                      if (playing) {
                        widget.audioPlayer.pause();
                      } else {
                        widget.audioPlayer.play();
                      }
                    },
                    icon: Icon(playing ? Icons.pause_rounded : Icons.play_arrow_rounded, color: Colors.white.withOpacity(0.7)),
                    iconSize: 60.0,
                  ),
                  const SizedBox(width: 8.0),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.fast_forward_rounded, color: Colors.white.withOpacity(0.7)),
                    iconSize: 60.0,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Text(duration != null ? durationToString(Duration(milliseconds: (position * duration!.inMilliseconds).round())) : '0:00'),
                  Expanded(
                    child: SliderTheme(
                      data: const SliderThemeData(
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7.0),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 18.0),
                      ),
                      child: Slider(
                        value: position,
                        activeColor: Colors.white.withOpacity(0.7),
                        inactiveColor: Colors.grey.shade900.withOpacity(0.7),
                        thumbColor: Colors.white,
                        onChanged: duration != null ? (value) => setState(() => position = value) : null,
                        onChangeStart: duration != null ? (value) => dragging = true : null,
                        onChangeEnd: duration != null
                            ? (value) {
                                position = value;
                                widget.audioPlayer.seek(Duration(milliseconds: (position * duration!.inMilliseconds).round()));
                                dragging = false;
                              }
                            : null,
                      ),
                    ),
                  ),
                  Text(duration != null ? durationToString(duration!) : '0:00'),
                ],
              ),
            ],
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
