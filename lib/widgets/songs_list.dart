import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musi_sync/model/song.dart';
import 'package:musi_sync/providers/liked_songs_provider.dart';

import '../providers/song_provider.dart';
import '../screens/song_details_screen.dart';

class SongsListScreen extends ConsumerWidget {
  const SongsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Song> songs = ref.watch(songsProvider);
    final List<Song> likedSongs = ref.watch(likedSongsProvider);
    final likedSongsNotifier = ref.read(likedSongsNotifierProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          // Show bottom sheet when the card is tapped
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return FractionallySizedBox(
                heightFactor: 0.80,
                child: Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    return ListView.builder(
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        final song = songs.length > index ? songs[index] : null;
                
                        if (song == null) return const SizedBox();
                
                        return GestureDetector(
                          onTap: () {
                            // Navigate to new screen when ListTile is tapped
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SongDetailsScreen(song: song)),
                            );
                          },
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(song.imageUrl),
                                ),
                                title: Text(song.title),
                                subtitle: Text(song.artist),
                                trailing: IconButton(
                                  icon: Consumer(
                                    builder: (context, watch, child) {
                                      final isLiked = likedSongs.contains(
                                          song); // Access likedSongs from provider
                                      return Icon(
                                        Icons.favorite,
                                        color: isLiked ? Colors.red : Colors.grey,
                                      );
                                    },
                                  ),
                                  onPressed: () {
                                    if (likedSongs.contains(song)) {
                                      likedSongsNotifier.removeLikedSong(song);
                                    } else {
                                      likedSongsNotifier.addLikedSong(song);
                                    }
                                    // You may also want to refresh the UI here (optional)
                                  },
                                ),
                              ),
                              const Divider(),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
        child: Card(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: const LinearGradient(
                colors: [
                  Colors.orangeAccent,
                  Colors.redAccent
                ], // Your gradient colors
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.library_music_outlined,
                  size: 64,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Text(
                  'Top Tracks',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:musi_sync/model/song.dart';
// import 'package:musi_sync/providers/liked_songs_provider.dart';

// import '../providers/song_provider.dart';

// class SongsListScreen extends ConsumerWidget {
//   const SongsListScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final List<Song> songs = ref.watch(songsProvider);
//     final List<Song> likedSongs = ref.watch(likedSongsProvider);
//     final likedSongsNotifier = ref.read(likedSongsNotifierProvider);

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: GestureDetector(
//         onTap: () {
//           // Show bottom sheet when the card is tapped
//           showModalBottomSheet(
//             context: context,
//             isScrollControlled: true,
//             builder: (BuildContext context) {
//               return FractionallySizedBox(
//                 heightFactor: 0.80,
//                 child: Consumer(
//                   builder: (BuildContext context, WidgetRef ref, Widget? child) {
//                     return ListView.builder(
//                       itemCount: songs.length,
//                       itemBuilder: (context, index) {
//                         final song = songs.length > index ? songs[index] : null;
                
//                         if (song == null) return const SizedBox();
                
//                         return Column(
//                           children: [
//                             ListTile(
//                               leading: CircleAvatar(
//                                 backgroundImage: NetworkImage(song.imageUrl),
//                               ),
//                               title: Text(song.title),
//                               subtitle: Text(song.artist),
//                               trailing: IconButton(
//                                 icon: Consumer(
//                                   builder: (context, watch, child) {
//                                     final isLiked = likedSongs.contains(
//                                         song); // Access likedSongs from provider
//                                     return Icon(
//                                       Icons.favorite,
//                                       color: isLiked ? Colors.red : Colors.grey,
//                                     );
//                                   },
//                                 ),
//                                 onPressed: () {
//                                   if (likedSongs.contains(song)) {
//                                     likedSongsNotifier.removeLikedSong(song);
//                                   } else {
//                                     likedSongsNotifier.addLikedSong(song);
//                                   }
//                                   // You may also want to refresh the UI here (optional)
//                                 },
//                               ),
//                             ),
//                             const Divider(),
//                           ],
//                         );
//                       },
//                     );
//                   },
//                 ),
//               );
//             },
//           );
//         },
//         child: Card(
//           color: Colors.transparent,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           elevation: 0,
//           child: Container(
//             width: 150,
//             height: 150,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               gradient: const LinearGradient(
//                 colors: [
//                   Colors.orangeAccent,
//                   Colors.redAccent
//                 ], // Your gradient colors
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: const Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.library_music_outlined,
//                   size: 64,
//                   color: Colors.white,
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Top Tracks',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white, // Text color
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
