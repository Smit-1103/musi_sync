import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for a song...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                ),
                onChanged: (value) {
                  // Handle search query changes
                  print('Search query: $value');
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'POP Hits',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enableInfiniteScroll: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
              ),
              items: List.generate(5, (index) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'POP Hit $index',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Playlists',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              height: 200, // Height of the row
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle tap event
                      print('Tapped on Card 1');
                    },
                    child: Card(
                      child: Container(
                        width: 150, // Width of each card
                        height: 150, // Height of each card
                        child: const Center(
                          child: Text('Card 1'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle tap event
                      print('Tapped on Card 2');
                    },
                    child: Card(
                      child: Container(
                        width: 150, // Width of each card
                        height: 150, // Height of each card
                        child: const Center(
                          child: Text('Card 2'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Fav Artists',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              height: 150, // Height of the row
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle tap event
                      print('Tapped on Card 1');
                    },
                    child: Card(
                      child: Container(
                        width: 120, // Width of each card
                        height: 120, // Height of each card
                        child: const Center(
                          child: Text('Card 1'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle tap event
                      print('Tapped on Card 2');
                    },
                    child: Card(
                      child: Container(
                        width: 120, // Width of each card
                        height: 120, // Height of each card
                        child: const Center(
                          child: Text('Card 2'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
