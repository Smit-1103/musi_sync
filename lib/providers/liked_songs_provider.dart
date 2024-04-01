import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musi_sync/model/song.dart';

// StateProvider to manage the list of liked songs
final likedSongsProvider = StateProvider<List<Song>>((ref) {
  return []; //at the start the list shlud be empty
});

// Separate provider to avoid direct modification of the liked songs list (optional)
final likedSongsNotifierProvider = Provider((ref) {
  return LikedSongsNotifier(
      ref.read(likedSongsProvider)); // Access liked songs list
});

class LikedSongsNotifier {
  final List<Song> likedSongs;

  LikedSongsNotifier(this.likedSongs);

  // Method to add a song to the liked list
  void addLikedSong(Song song) {
    if (!likedSongs.contains(song)) {
      likedSongs.add(song);
    }
  }

  // Method to remove a song from the liked list
  void removeLikedSong(Song song) {
    likedSongs.remove(song);
  }

  // Check if a song is liked
  bool isLiked(Song song) => likedSongs.contains(song);
}
