import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../model/song.dart';

class SongDetailsScreen extends StatefulWidget {
  final Song song;

  const SongDetailsScreen({super.key, required this.song});

  @override
  State<SongDetailsScreen> createState() => _SongDetailsScreenState();
}

class _SongDetailsScreenState extends State<SongDetailsScreen> {
  bool _isPlaying = false;
  double _currentPlaybackPosition = 0.0; // To store current position
  late final AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.song.title),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    10.0), // Adjust corner radius as desired
              ),
              child: SizedBox(
                height: 300,
                width: 300,
                child: Image.network(
                  widget.song.imageUrl,
                  fit: BoxFit.cover, // Fills the entire card area
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.song.title,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 8),
            Text(
              widget.song.artist,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Slider(
              value:
                  _currentPlaybackPosition, // Update value as song progresses
              onChanged: (value) {
                _player.seek(Duration(seconds: value.toInt()));
                setState(() {
                  _currentPlaybackPosition = value;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatDuration(_currentPlaybackPosition)),
                Text(formatDuration(widget.song.duration)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  onPressed: () {
                    // Implement previous song functionality
                  },
                ),
                IconButton(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () {
                    setState(() {
                      _isPlaying = !_isPlaying;
                      if (_isPlaying) {
                        _player.play();
                      } else {
                        _player.pause();
                      }
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  onPressed: () {
                    // Implement next song functionality
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatDuration(double seconds) {
    int minutes = (seconds ~/ 60).clamp(0, 99);
    int secondsRemaining = (seconds % 60).toInt().clamp(0, 59);
    return "${minutes.toString().padLeft(2, '0')}:${secondsRemaining.toString().padLeft(2, '0')}";
  }
}










// import 'package:flutter/material.dart';
// import '../model/song.dart';

// class SongDetailsScreen extends StatefulWidget {
//   final Song song;

//   const SongDetailsScreen({super.key, required this.song});

//   @override
//   State<SongDetailsScreen> createState() => _SongDetailsScreenState();
// }

// class _SongDetailsScreenState extends State<SongDetailsScreen> {
//   bool _isPlaying = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.song.title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Text(
//               widget.song.title,
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 8),
//             Text(
//               widget.song.artist,
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 16),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 3,
//                     blurRadius: 7,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image.network(
//                   widget.song.imageUrl,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             // Seek bar widget goes here
//             // Control buttons row goes here
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.skip_previous),
//                   onPressed: () {
//                     // Implement previous song functionality
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
//                   onPressed: () {
//                     setState(() {
//                       _isPlaying = !_isPlaying;
//                       // Implement play/pause functionality
//                     });
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.skip_next),
//                   onPressed: () {
//                     // Implement next song functionality
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }










// import 'package:flutter/material.dart';

// import '../model/song.dart';

// class SongDetailsScreen extends StatelessWidget {
//   final Song song;

//   const SongDetailsScreen({super.key, required this.song});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(song.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               song.title,
//               style: TextStyle(fontSize: 24),
//             ),
//             Text(
//               song.artist,
//               style: TextStyle(fontSize: 18),
//             ),
//             Image.network(song.imageUrl),
//           ],
//         ),
//       ),
//     );
//   }
// }