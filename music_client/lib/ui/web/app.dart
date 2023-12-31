import 'dart:async';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:music_client/client/auth.dart' as auth;
import 'package:music_client/theme.dart';
import 'package:music_client/ui/landing/landing_scaffold.dart';
import 'package:music_client/ui/web/app_scaffold.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Client',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: const PreloadPage(),
    );
  }
}

class PreloadPage extends StatefulWidget {
  const PreloadPage({super.key});

  @override
  State<PreloadPage> createState() => _PreloadPageState();
}

class _PreloadPageState extends State<PreloadPage> {
  late final GlobalKey homePageKey;
  late final GlobalKey landingPageKey;

  late final StreamSubscription authStateChangedSubscription;

  late bool loaded;
  late bool authenticated;

  @override
  void initState() {
    homePageKey = GlobalKey();
    landingPageKey = GlobalKey();

    authStateChangedSubscription = auth.authStateChanged.listen((event) {
      final newAuthenticated = event != null;
      if (authenticated != newAuthenticated) {
        setState(() => authenticated = newAuthenticated);
      }
    });

    loaded = false;
    authenticated = false;

    preload().then((value) => setState(() => loaded = true));
    super.initState();
  }

  Future<void> preload() async {
    if (await auth.autoSessionRefresh()) authenticated = true;
  }

  @override
  Widget build(BuildContext context) {
    return !loaded
        ? const Scaffold(body: Align(alignment: Alignment.topCenter, child: LinearProgressIndicator()))
        : AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: authenticated ? AppScaffold(key: homePageKey) : LandingScaffold(key: landingPageKey),
          );
  }
}

Future<Uint8List?> getBytesFromPickedFile(PlatformFile result) async {
  if (result.readStream != null) {
    final bytes = <int>[];
    await for (final chunk in result.readStream!) {
      bytes.addAll(chunk);
    }
    return Uint8List.fromList(bytes);
  } else {
    return result.bytes;
  }
}
