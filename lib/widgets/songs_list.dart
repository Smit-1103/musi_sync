import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musi_sync/model/song.dart';
import 'package:musi_sync/providers/liked_songs_provider.dart';

import '../providers/song_provider.dart';

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
            builder: (BuildContext context) {
              return Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      final song = songs.length > index ? songs[index] : null;

                      if (song == null) return const SizedBox();

                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(song.imageUrl),
                            ),
                            title: Text(song.title),
                            subtitle: Text(song.artist),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: likedSongs.contains(song)
                                    ? Colors.red
                                    : Colors.grey,
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
                      );
                    },
                  );
                },
              );
            },
          );
        },
        child: const Card(
          child: SizedBox(
            width: 150,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.library_music_outlined,
                  size: 64,
                  color: Colors.black,
                ),
                SizedBox(height: 8),
                Text(
                  'Top Tracks',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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