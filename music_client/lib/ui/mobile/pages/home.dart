import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_client/ui/widgets/song_image.dart';
import 'package:music_client/ui/widgets/ultra_gradient.dart';
import 'package:music_shared/music_shared.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final genres = List.generate(6, (index) => 'genre ${index + 1}');

class _HomePageState extends State<HomePage> {
  String? selectedGenre;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedUltraGradient(
        duration: const Duration(seconds: 10),
        opacity: 0.1,
        pointSize: 750.0,
        child: CustomScrollView(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.5),
                        child: Text('W',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.75),
                                )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(24.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 160.0,
                  crossAxisSpacing: 8.0,
                  mainAxisExtent: 50.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final genre = genres[index];
                    return Theme(
                      data: Theme.of(context).copyWith(canvasColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.2)),
                      child: FilterChip(
                        label: Text(genre),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                        selected: genre == selectedGenre,
                        onSelected: (value) {
                          if (value) {
                            setState(() => selectedGenre = genre);
                          } else {
                            setState(() => selectedGenre = null);
                          }
                        },
                      ),
                    );
                  },
                  childCount: genres.length,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(24.0),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Wrap(
                    spacing: 24.0,
                    runSpacing: 24.0,
                    children: List.generate(4, (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 150.0,
                            height: 150.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              image: DecorationImage(image: CachedNetworkImageProvider(getSongImageUrl('018cbd88-765d-715f-a87c-5151c53c9dca', ImageSize.small))),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          const Text('Blinding Lights'),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 018cb253-d224-74da-9c70-09a341be0a3a

// SliverToBoxAdapter(
//                 child: Wrap(
//                   alignment: WrapAlignment.center,
//                   spacing: 14.0,
//                   runSpacing: 24.0,
//                   children: genres
//                       .map((genre) => FilterChip(
//                             label: Text(genre),
//                             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                             selected: genre == selectedGenre,
//                             onSelected: (value) {
//                               if (value) {
//                                 setState(() => selectedGenre = genre);
//                               } else {
//                                 setState(() => selectedGenre = null);
//                               }
//                             },
//                           ))
//                       .toList(),
//                 ),
//               ),

