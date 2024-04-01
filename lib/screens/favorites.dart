import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:musi_sync/providers/liked_songs_provider.dart';
import '../model/song.dart';
import 'song_details_screen.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Song> likedSongs = ref.watch(likedSongsProvider);
    final likedSongsNotifier = ref.read(likedSongsNotifierProvider);

    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 180,
            height: 180,
            child: Lottie.asset(
              'assets/images/empty.json',
              repeat: false,
            ),
          ),
          Text(
            'uh ohh... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Add your favorite songs here...',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

    if (likedSongs.isNotEmpty) {
      content = ListView.builder(
        itemCount: likedSongs.length,
        itemBuilder: (context, index) {
          final song = likedSongs.length > index ? likedSongs[index] : null;

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
                    color: likedSongs.contains(song) ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    // Remove song from liked list using likedSongsNotifier
                    likedSongsNotifier.removeLikedSong(song);
                  },
                ),
                // Add this line for navigation to SongDetailsScreen
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SongDetailsScreen(song: song),
                    ),
                  );
                },
              ),
              const Divider(),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: content,
    );
  }
}
