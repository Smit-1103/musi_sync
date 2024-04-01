import 'package:flutter/material.dart';
import 'package:musi_sync/screens/favorites.dart';
import 'package:musi_sync/screens/home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isHomeSelected = true;
  bool _isLeftToRight = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_isHomeSelected ? 'MusiSync' : 'Favorites'),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _isHomeSelected ? HomeScreen() : const FavoritesScreen(),
        transitionBuilder: (child, animation) {
          final slideAnimation = Tween<Offset>(
            begin: _isLeftToRight
                ? const Offset(-1.0, 0.0)
                : const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(
            position: slideAnimation,
            child: child,
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isHomeSelected = true;
                    _isLeftToRight = !_isHomeSelected;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                    color: _isHomeSelected ? Colors.blue : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: _isHomeSelected ? Colors.white : Colors.black,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Home',
                        style: TextStyle(
                            color:
                                _isHomeSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isHomeSelected = false;
                    _isLeftToRight = !_isHomeSelected;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                    color: !_isHomeSelected ? Colors.blue : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: !_isHomeSelected ? Colors.white : Colors.black,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Favorites',
                        style: TextStyle(
                          color: !_isHomeSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
