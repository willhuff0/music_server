import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:music_client/client/auth.dart';
import 'package:music_client/client/song.dart';
import 'package:music_client/ui/web/pages/upload_song.dart';
import 'package:music_client/ui/widgets/song_image.dart';
import 'package:music_shared/music_shared.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';

class MyContentPage extends StatefulWidget {
  const MyContentPage({super.key});

  @override
  State<MyContentPage> createState() => _MyContentPageState();
}

class _MyContentPageState extends State<MyContentPage> {
  static const _pageSize = 10;

  late final PagingController<int, Song> _pagingController;

  @override
  void initState() {
    _pagingController = PagingController(firstPageKey: 0)..addPageRequestListener(_fetchPage);
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    if (identityTokenObject == null || identityTokenObject!.userId == null) {
      _pagingController.error = 'Error: not logged in';
      return;
    }
    final newSongs = await filterSongs(owner: identityTokenObject!.userId!, start: pageKey == 0 ? null : pageKey);
    if (newSongs == null || newSongs.isEmpty) {
      _pagingController.appendLastPage([]);
    } else {
      if (newSongs.length < _pageSize) {
        _pagingController.appendLastPage(newSongs);
      } else {
        _pagingController.appendPage(newSongs, pageKey + newSongs.length);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DynMouseScroll(
      builder: (context, controller, physics) {
        return CustomScrollView(
          controller: controller,
          physics: physics,
          slivers: [
            SliverList.list(
              children: [
                const SizedBox(height: 150.0),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SizedBox(
                      width: 775.0,
                      child: Row(
                        children: [
                          Text('My Content', style: Theme.of(context).textTheme.titleLarge),
                          Expanded(child: Container()),
                          IconButton(
                            onPressed: () {
                              _pagingController.refresh();
                            },
                            icon: const Icon(Icons.refresh_rounded),
                          ),
                          const SizedBox(width: 24.0),
                          FloatingActionButton.extended(
                            onPressed: () async {
                              final result = await showDialog<bool>(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => const Dialog(child: UploadSongPage()),
                              );
                              if (result ?? false) {
                                _pagingController.refresh();
                              }
                            },
                            icon: const Icon(Icons.add_rounded),
                            label: const Text('Upload Song'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            PagedSliverList(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Song>(
                itemBuilder: (context, item, index) {
                  return Center(
                    child: Card(
                      margin: const EdgeInsets.all(6.0),
                      child: SizedBox(
                        height: 200,
                        width: 1000,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.0),
                                      image: DecorationImage(image: NetworkImage(getSongImageUrl(item.id, ImageSize.medium))),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 175.0,
                                right: 0.0,
                                top: 0.0,
                                bottom: 0.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(item.name, style: Theme.of(context).textTheme.titleLarge),
                                    const SizedBox(height: 8.0),
                                    Text(item.description, style: Theme.of(context).textTheme.bodyLarge),
                                    Expanded(child: Container()),
                                    const SizedBox(height: 8.0),
                                    Tooltip(
                                      message: 'Listen count',
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.headphones_rounded, color: Theme.of(context).colorScheme.primary.withOpacity(0.3), size: 20.0),
                                          const SizedBox(width: 8.0),
                                          Text(item.numPlays.toString()),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                noItemsFoundIndicatorBuilder: (context) => Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(64.0),
                    child: Column(
                      children: [
                        Text('You have no content yet', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 4.0),
                        Text('Upload a song to get started', style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
