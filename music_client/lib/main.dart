import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'package:music_client/ui/mobile/app.dart'; // if (dart.library.html) 'package:music_client/ui/web/app.dart';
//import 'package:music_client/ui/web/app.dart';

void main() async {
  if (!Platform.isWindows && !Platform.isLinux) {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.willhuffman.music_client.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    );
  }
  runApp(const MyApp());
}
