import 'package:flutter/material.dart';
import 'package:music_client/client/song.dart';
import 'package:music_client/ui/mobile/app_scaffold.dart';
import 'package:music_client/ui/widgets/song_display.dart';
import 'package:music_client/ui/widgets/song_image.dart';
import 'package:music_shared/music_shared.dart';
import 'package:palette_generator/palette_generator.dart';

class SongPage extends StatefulWidget {
  final Song song;

  const SongPage({super.key, required this.song});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  late ImageProvider image;
  List<Color>? colors;

  @override
  void initState() {
    image = NetworkImage(getSongImageUrl(widget.song.id, ImageSize.medium));
    PaletteGenerator.fromImageProvider(image).then((value) {
      final paletteColors = value.colors.toList()..shuffle();
      setState(() => colors = paletteColors.take(4).toList());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SongDisplay(
        id: widget.song.id,
        name: widget.song.name,
        description: widget.song.description,
        duration: widget.song.duration,
        image: image,
        colors: colors,
        audioPlayer: appPlayer,
      ),
    );
  }
}
