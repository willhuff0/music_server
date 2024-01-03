import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_client/client/song.dart';
import 'package:music_client/ui/mobile/sync.dart';
import 'package:music_client/ui/mobile/app_scaffold.dart';
import 'package:music_client/ui/widgets/song_image.dart';
import 'package:music_shared/music_shared.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription syncSessionChangedSubscription;

  List<Song>? songs;

  Set<Genre> selectedGenres = {};

  @override
  void initState() {
    syncSessionChangedSubscription = syncSessionChanged.listen((_) => setState(() {}));
    popularSongs().then((value) {
      if (mounted) setState(() => songs = value);
    });
    super.initState();
  }

  void selectGenre(Genre genre) {
    if (!selectedGenres.add(genre)) {
      selectedGenres.remove(genre);
    }

    if (selectedGenres.isNotEmpty) {
      setState(() => songs = null);
      filterSongs(genres: selectedGenres.toList()).then((value) {
        if (mounted) setState(() => songs = value);
      });
    } else {
      setState(() => songs = null);
      popularSongs().then((value) {
        if (mounted) setState(() => songs = value);
      });
    }
  }

  @override
  void dispose() {
    syncSessionChangedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar.medium(
          backgroundColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.scrolledUnder)) {
              return Theme.of(context).colorScheme.surface.withOpacity(0.95);
            } else {
              return Colors.transparent;
            }
          }),
          expandedHeight: 100.0,
          toolbarHeight: 60.0,
          collapsedHeight: 60.0,
          flexibleSpace: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 14.0, bottom: 14.0),
                child: FittedBox(child: Text('Music Client', style: Theme.of(context).textTheme.headlineLarge)),
              ),
              Expanded(child: Container()),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
              //   child: MenuAnchor(
              //     menuChildren: [
              //       syncSession == null
              //           ? MenuItemButton(
              //               child: const Text('Join Sync Session'),
              //               onPressed: () async {
              //                 await startOrJoinSyncSession();
              //               },
              //             )
              //           : MenuItemButton(
              //               child: const Text('Leave Sync Session'),
              //               onPressed: () async {
              //                 await syncSession?.disconnect();
              //                 syncSession = null;
              //                 syncSessionChangedController.add(syncSession);
              //               },
              //             ),
              //       const PopupMenuDivider(),
              //       MenuItemButton(
              //         child: const Text('Sign Out'),
              //         onPressed: () {
              //           signOut();
              //         },
              //       )
              //     ],
              //     builder: (context, controller, child) {
              //       return IconButton(
              //         onPressed: () {
              //           controller.open();
              //         },
              //         icon: CircleAvatar(
              //           backgroundColor: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.5),
              //           child: Text(
              //             identityTokenObject!.displayName!.substring(0, 1).toUpperCase(),
              //             style: Theme.of(context).textTheme.labelLarge?.copyWith(
              //                   color: Theme.of(context).colorScheme.onBackground.withOpacity(0.75),
              //                 ),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                child: IconButton(
                  tooltip: syncSession == null ? 'Join Sync Session' : 'Leave Sync Session',
                  onPressed: () async {
                    if (syncSession == null) {
                      await startOrJoinSyncSession();
                    } else {
                      await syncSession?.disconnect();
                      syncSession = null;
                      syncSessionChangedController.add(syncSession);
                    }
                  },
                  icon: Icon(syncSession == null ? Icons.lan_outlined : Icons.lan_rounded),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
              //   child: IconButton(
              //     onPressed: () {},
              //     icon: CircleAvatar(
              //       backgroundColor: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.5),
              //       child: Text(
              //         identityTokenObject!.displayName!.substring(0, 1).toUpperCase(),
              //         style: Theme.of(context).textTheme.labelLarge?.copyWith(
              //               color: Theme.of(context).colorScheme.onBackground.withOpacity(0.75),
              //             ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(24.0),
          sliver: SliverToBoxAdapter(
            child: Theme(
              data: Theme.of(context).copyWith(canvasColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.2)),
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 8.0,
                runSpacing: 10.0,
                children: Genre.values
                    .map((genre) => FilterChip(
                          label: Text(genre.displayName),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                          selected: selectedGenres.contains(genre),
                          onSelected: (value) => selectGenre(genre),
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(24.0),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: songs != null
                  ? songs!.isNotEmpty
                      ? Wrap(
                          spacing: 14.0,
                          runSpacing: 14.0,
                          children: songs!.map((song) {
                            return InkWell(
                              splashFactory: InkRipple.splashFactory,
                              borderRadius: BorderRadius.circular(14.0),
                              onTap: () async {
                                await selectSong(song);
                                if (mounted) setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 14.0, right: 14.0, top: 14.0, bottom: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 150.0,
                                      height: 150.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16.0),
                                        image: DecorationImage(image: CachedNetworkImageProvider(getSongImageUrl(song.id, ImageSize.medium))),
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Text(song.name, style: Theme.of(context).textTheme.titleMedium),
                                    ),
                                    const SizedBox(height: 2.0),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Text(
                                        song.ownerName,
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8)),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList())
                      : const Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Text('No results :('),
                        )
                  : const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}


// SliverGrid(
//             gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//               maxCrossAxisExtent: 130.0,
//               crossAxisSpacing: 8.0,
//               mainAxisExtent: 50.0,
//             ),
//             delegate: SliverChildBuilderDelegate(
//               (context, index) {
//                 final genre = Genre.values[index];
//                 return Theme(
//                   data: Theme.of(context).copyWith(canvasColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.2)),
//                   child: FilterChip(
//                     label: Text(genre.displayName),
//                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
//                     selected: genre == selectedGenres,
//                     onSelected: (value) {
//                       if (value) {
//                         setState(() => selectedGenres = genre);
//                       } else {
//                         setState(() => selectedGenres = null);
//                       }
//                     },
//                   ),
//                 );
//               },
//               childCount: Genre.values.length,
//             ),
//           ),