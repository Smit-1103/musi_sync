import 'package:flutter/material.dart';
import 'package:musi_sync/model/song.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<Song> favoriteSongs = [
    Song(
      title: 'Song 1',
      artist: 'Artist 1',
      imageUrl: 'https://example.com/image1.jpg',
      isLiked: true,
    ),
    Song(
      title: 'Song 2',
      artist: 'Artist 2',
      imageUrl: 'https://example.com/image2.jpg',
      isLiked: false,
    ),
    // Add more songs as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favoriteSongs.length,
        itemBuilder: (context, index) {
          final song = favoriteSongs[index];
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
                    color: song.isLiked ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      song.isLiked = !song.isLiked;
                    });
                  },
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}