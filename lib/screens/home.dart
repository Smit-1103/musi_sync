import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musi_sync/screens/song_details_screen.dart';
import 'package:musi_sync/widgets/songs_list.dart';

import '../model/song.dart';
import '../providers/liked_songs_provider.dart';
import '../providers/search_query_provider.dart';
import '../providers/song_provider.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final List<String> imageUrls = [
    'https://akm-img-a-in.tosshub.com/indiatoday/images/story/202206/kk_1.png?VersionId=DEs3YHvuLkIqm.suu.VoS5l3LalQ1kgj',
    'https://thumbs.dreamstime.com/b/silhouettes-concert-crowd-front-bright-stage-lights-confetti-colourful-background-high-lighted-places-people-holding-83284529.jpg',
    'https://imagevars.gulfnews.com/2021/11/21/Arijit-Singh_17d427db2ed_large.JPG',
    'https://cdn.pixabay.com/photo/2016/11/23/15/48/audience-1853662_1280.jpg',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Song> likedSongs = ref.watch(likedSongsProvider);

    final likedSongsNotifier = ref.read(likedSongsNotifierProvider);

    //
    final songs = ref.watch(songsProvider);
    final searchQuery =
        ref.watch(searchQueryProvider); // provider for search query

    void _handleSearch(String value) {
      // Update search query provider
      ref.read(searchQueryProvider.notifier).state = value.toLowerCase();
    }

    List<Song> filteredSongs(List<Song> allSongs, String query) {
      if (query.isEmpty) {
        return allSongs;
      }
      return allSongs
          .where((song) =>
              song.title.toLowerCase().contains(query) ||
              song.artist.toLowerCase().contains(query))
          .toList();
    }

    filteredSongs(songs, searchQuery);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for a song...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                ),
                onChanged: _handleSearch,
                //
              ),
            ),
            if (searchQuery.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: SizedBox(
                    height: 200, // Adjust height as needed
                    child: ListView.builder(
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        final song = songs[index];
                        final shouldShowSong = searchQuery.isEmpty ||
                            song.title.toLowerCase().contains(searchQuery) ||
                            song.artist.toLowerCase().contains(searchQuery);
                        if (shouldShowSong) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SongDetailsScreen(song: song),
                                ),
                              );
                            },
                            child: Container(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1), // Light grey color
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(song.imageUrl),
                                  ),
                                  title: Text(song.title),
                                  subtitle: Row(
                                    children: [
                                      AutoSizeText(
                                        song.artist,
                                        maxLines: 1,
                                        minFontSize: 12,
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Consumer(
                                      builder: (context, watch, child) {
                                        final isLiked = likedSongs.contains(
                                            song); // Access likedSongs from provider
                                        return Icon(
                                          Icons.favorite,
                                          color: isLiked
                                              ? Colors.red
                                              : Colors.grey,
                                        );
                                      },
                                    ),
                                    onPressed: () {
                                      if (likedSongs.contains(song)) {
                                        likedSongsNotifier
                                            .removeLikedSong(song);
                                      } else {
                                        likedSongsNotifier.addLikedSong(song);
                                      }
                                      // You may also want to refresh the UI here (optional)
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container(); // Placeholder for empty space
                        }
                      },
                    ),
                  ),
                ),
              ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'POP Hits',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 230,
                autoPlay: true,
                enableInfiniteScroll: true,
                autoPlayInterval: const Duration(seconds: 2),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.easeInOutCirc,
                enlargeCenterPage: true,
              ),
              items: imageUrls.map((imageUrl) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Builder(
                    builder: (BuildContext context) {
                      return Image.network(
                        imageUrl,
                        fit: BoxFit.cover, // Adjust fit as needed
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Text(
                                'Error loading image'), // Placeholder on error
                          );
                        },
                      );
                    },
                  ),
                );
              }).toList(),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Trending Songs',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SongsListScreen(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Fav Artists',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              height: 150, // Height of the row
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildImageCard(
                      context: context,
                      imageUrl:
                          'https://media.assettype.com/knocksense%2F2023-05%2Febf7574b-a5ab-4a99-a9b6-c9c05de5d975%2FDarshan_Raval_Concert_2023.jpg',
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    _buildImageCard(
                      context: context,
                      imageUrl:
                          'https://cdn.siasat.com/wp-content/uploads/2024/01/Atif-Aslam.jpg',
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    _buildImageCard(
                      context: context,
                      imageUrl:
                          'https://lastfm.freetls.fastly.net/i/u/ar0/efdb59add7dc40f6afbcdd090434fe76.jpg',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildImageCard(
    {required BuildContext context, required String imageUrl}) {
  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: SizedBox(
                width: 350,
                height: 350,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Adjust the radius as needed
      ),
      child: SizedBox(
        width: 120,
        height: 120,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}


// Widget _buildImageCard({required BuildContext context, required String imageUrl}) {
//   return GestureDetector(
//     onTap: () {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             contentPadding: EdgeInsets.zero,
//             content: SizedBox(
//               width: 350,
//               height: 350,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20.0),
//                 child: Image.network(
//                   imageUrl,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           );
//         },
//       );
//     },
//     child: Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
//       ),
//       child: SizedBox(
//         width: 120,
//         height: 120,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20.0),
//           child: Image.network(
//             imageUrl,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     ),
//   );
// }
