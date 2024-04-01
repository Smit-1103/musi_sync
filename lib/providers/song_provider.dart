import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musi_sync/model/song.dart';
import 'package:uuid/uuid.dart';

import '../data/dmmy_data.dart';

// StateNotifier class to manage the list of songs
final songsProvider = StateNotifierProvider<SongsNotifier, List<Song>>((ref) {
  return SongsNotifier(dummySongs);
});

//
final filteredSongsProvider = StateProvider<List<Song>>((ref) => []);
//

class SongsNotifier extends StateNotifier<List<Song>> {
  SongsNotifier(super.initialSongs);

  // Method to add a song to the list
  void addSong(Song song) {
    state = [
      ...state,
      song.copyWith(id: const Uuid().v4())
    ]; // Generate unique ID
  }

  // Method to remove a song from the list
  void removeSong(Song song) {
    state = state.where((s) => s != song).toList();
  }
}




// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../data/dmmy_data.dart';

// final songsProvider = Provider((ref) {
//   // final initialSongs = dummySongs
//   //     .map((song) => song.copyWith(isLiked: false))
//   //     .toList(); // Set initial isLiked to false

//   return dummySongs;
// });
