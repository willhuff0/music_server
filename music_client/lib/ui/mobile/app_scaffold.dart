import 'package:flutter/material.dart';
import 'package:music_client/ui/mobile/pages/home.dart';
import 'package:music_client/ui/mobile/pages/my_music.dart';
import 'package:music_client/ui/mobile/pages/search.dart';

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
