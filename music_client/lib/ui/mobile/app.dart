import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:music_client/client/client.dart';
import 'package:music_client/client/auth.dart' as auth;
import 'package:music_client/ui/landing/landing_scaffold.dart';
import 'package:music_client/ui/mobile/pages/home.dart';
import 'package:music_client/ui/mobile/pages/my_music.dart';
import 'package:music_client/ui/mobile/pages/search.dart';
import 'package:music_client/theme.dart';

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
    runSpeedTestOnConnectivityChanged();
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

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  var index = 0;

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
        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.75),
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

Future<Uint8List?> getBytesFromPickedFile(PlatformFile result) async {
  if (result.path != null) {
    return await File(result.path!).readAsBytes();
  } else {
    return result.bytes;
  }
}
