import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class Song {
  final String id;
  final String title;
  final String artist;
  final String imageUrl;
  bool isLiked;

  Song({
    String? id,
    required this.title,
    required this.artist,
    required this.imageUrl,
    this.isLiked = false,
  }) : id = id ?? const Uuid().v4(); // Generate UUID if id is null

  Song copyWith({
    String? id,
    String? title,
    String? artist,
    String? imageUrl,
    bool? isLiked,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      imageUrl: imageUrl ?? this.imageUrl,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}

class SongsNotifier extends StateNotifier<List<Song>> {
  SongsNotifier() : super([]);

  // Method to add a song to the list
  void addSong(Song song) {
    state = [...state, song];
  }

  // Method to remove a song from the list
  void removeSong(Song song) {
    state = state.where((s) => s != song).toList();
  }
}
