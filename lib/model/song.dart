import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class Song {
  final String id;
  final String title;
  final String artist;
  final String imageUrl;
  final double duration;
  final String audioUrl;
  bool isLiked;

  Song({
    String? id,
    required this.title,
    required this.artist,
    required this.imageUrl,
    this.isLiked = false,
    required this.duration,
    required this.audioUrl,
  }) : id = id ?? const Uuid().v4(); // Generate UUID if id is null

  Song copyWith({
    String? id,
    String? title,
    String? artist,
    String? imageUrl,
    double? duration,
    String? audioUrl,
    bool? isLiked,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      imageUrl: imageUrl ?? this.imageUrl,
      isLiked: isLiked ?? this.isLiked,
      duration: duration ?? this.duration,
      audioUrl: audioUrl ?? this.audioUrl,
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
