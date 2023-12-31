import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_client/client/client.dart';
import 'package:music_client/client/song.dart';
import 'package:music_client/ui/mobile/pages/home.dart';
import 'package:music_client/ui/mobile/pages/my_music.dart';
import 'package:music_client/ui/mobile/pages/search.dart';
import 'package:music_client/ui/mobile/pages/song.dart';
import 'package:music_shared/music_shared.dart';

late AudioPlayer appPlayer;

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

void selectSong(BuildContext context, Song song) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => SongPage(song: song)));
  print(song.duration);
  appPlayer.setAudioSource(MusicServerAudioSource(song: song, preset: getAudioPresetForCurrentDevice())).then((value) => print(value));
}

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  var index = 0;

  @override
  void initState() {
    appPlayer = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    appPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: index,
        children: const [
          HomePage(),
          SearchPage(),
          MyMusicPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        //elevation: 4.0,
        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.975),
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
    );
  }
}
