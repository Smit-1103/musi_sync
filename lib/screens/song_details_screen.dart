import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../model/song.dart';

class SongDetailsScreen extends StatefulWidget {
  final Song song;

  const SongDetailsScreen({super.key, required this.song});

  @override
  State<SongDetailsScreen> createState() => _SongDetailsScreenState();
}

class _SongDetailsScreenState extends State<SongDetailsScreen> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    setAudio();

    // listen for changes in the state of the player - play, paused , stopped
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    //listen to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    //listen to audioposition
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async {
    //for repeat song when completed
    audioPlayer.setReleaseMode(ReleaseMode.loop);

    //load audio from file using filepicker
    // final result = await FilePicker.platform.pickFiles();

    // if (result != null) {
    //   final file = File(result.files.single.path!);
    //   audioPlayer.setSourceUrl(file.path);
    // }

    //lod the song from assets
    final player = AudioCache(prefix: 'assets/audios/');
    final url = await player.load('stay.mp3');
    audioPlayer.setSourceUrl(url.path);
  }

  @override
  void dispose() {
    audioPlayer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
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
            //image
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SizedBox(
                height: 300,
                width: 300,
                child: Image.network(
                  widget.song.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            //title of the song
            Text(
              widget.song.title,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 8),
            //artist's name
            Text(
              widget.song.artist,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            //slider for the audio player
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds
                  .toDouble(), // Update value as song progresses
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);

                // play the song if it is stopped
                await audioPlayer.resume();
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatTime(position)),
                Text(formatTime(duration - position)),
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
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                    } else {
                      await audioPlayer.resume();
                    }
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

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
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
