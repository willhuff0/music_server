import 'package:flutter/material.dart';
import 'package:music_client/client/auth.dart';
import 'package:music_client/ui/web/pages/my_content.dart';
import 'package:music_client/ui/web/pages/settings.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  late final List<Widget> pages;

  var index = 0;

  @override
  void initState() {
    pages = [
      const MyContentPage(),
      const SettingsPage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationDrawer(
            //extended: true,
            elevation: 2.0,
            selectedIndex: index,
            backgroundColor: Colors.transparent,
            onDestinationSelected: (value) => setState(() => index = value),
            tilePadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 2.0),
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text('Music Client', style: Theme.of(context).textTheme.titleLarge),
                ),
              ),
              const NavigationDrawerDestination(icon: Icon(Icons.music_note_rounded), label: Text('My Content')),
              const NavigationDrawerDestination(icon: Icon(Icons.settings_rounded), label: Text('Settings')),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 56.0),
                child: FilledButton.tonal(
                  onPressed: () {
                    signOut();
                  },
                  child: const Text('Log out'),
                ),
              )
            ],
          ),
          Expanded(
            child: IndexedStack(
              sizing: StackFit.expand,
              index: index,
              children: pages,
            ),
          ),
        ],
      ),
    );
  }
}
