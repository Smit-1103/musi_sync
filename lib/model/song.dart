class Song {
  final String title;
  final String artist;
  final String imageUrl;
  bool isLiked;

  Song({
    required this.title,
    required this.artist,
    required this.imageUrl,
    this.isLiked = false,
  });
}

// class SongsNotifier extends StateNotifier<List<Song>> {
//   SongsNotifier() : super([]);

//   // Method to add a song to the list
//   void addSong(Song song) {
//     state = [...state, song];
//   }

//   // Method to remove a song from the list
//   void removeSong(Song song) {
//     state = state.where((s) => s != song).toList();
//   }
// }
