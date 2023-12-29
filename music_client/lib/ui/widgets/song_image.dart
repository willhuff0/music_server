import 'package:music_client/client/client.dart';
import 'package:music_shared/music_shared.dart';

String getSongImageUrl(String songId, ImageSize size) => 'http://$serverHost:$serverPort/song/getImage/$songId/${size.index}.webp';

// class SongImage extends StatelessWidget {
//   final String songId;
//   final ImageSize size;

//   const SongImage({super.key, required this.songId, required this.size});

//   @override
//   Widget build(BuildContext context) {
//     return Image.network(
//       'http://$serverHost:$serverPort/song/getImage/$songId/${size.index}.webp',
//       cacheWidth: size.sizeX.toDouble(),
//       cacheHeight: size.sizeY.toDouble(),
//     );
//   }
// }

// DecorationImage songImageDecorationImage({required String songId, required ImageSize size}) {
//   return DecorationImage(
//     fit: BoxFit.cover,
//     image: NetworkImage(
//       'http://$serverHost:$serverPort/song/getImage/$songId/${size.index}.webp',
//     ),
//   );
// }
