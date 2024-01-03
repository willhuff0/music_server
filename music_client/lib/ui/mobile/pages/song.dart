import 'package:flutter/material.dart';
import 'package:music_client/ui/mobile/app_scaffold.dart';
import 'package:music_client/ui/widgets/song_display.dart';

class SongPage extends StatelessWidget {
  final void Function() onClose;
  final bool isLandscape;

  const SongPage({super.key, required this.onClose, required this.isLandscape});

  @override
  Widget build(BuildContext context) {
    final song = currentlyPlayingSong!;
    return Stack(
      children: [
        SongDisplay(
          id: song.id,
          name: song.name,
          ownerName: song.ownerName,
          description: song.description,
          duration: song.duration,
          image: currentlyPlayingImageLarge!,
          colors: currentlyPlayingColors,
          audioPlayer: appPlayer,
          onPlay: play,
          onPause: pause,
          onSeek: seek,
          isLandscape: isLandscape,
        ),
        Positioned(
          top: 0.0,
          right: 0.0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 24.0, top: 8.0),
              child: IconButton(
                icon: const Icon(Icons.expand_more_rounded),
                onPressed: () {
                  onClose();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
