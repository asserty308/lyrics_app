import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/utility/extensions/int_duration.dart';
import 'package:flutter_core/utility/keyboard.dart';
import 'package:lyrics/features/favorites/ui/screens/favorites_screen.dart';
import 'package:lyrics/features/settings/ui/screens/settings_screen.dart';
import 'package:lyrics/features/song_search/ui/screens/search_song_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[ 
          Positioned.fill(
            child: IndexedStack(
              index: _currentNavIndex,
              children: <Widget>[
                FavoritesScreen(),
                SearchSongScreen(),
                SettingsScreen(),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CurvedNavigationBar(
              color: Color.fromARGB(255, 1, 1, 1),
              backgroundColor: Colors.transparent,
              animationDuration: 250.toMilliseconds(),
              items: <Widget>[
                Icon(Icons.favorite, size: 30, color: Colors.white,),
                Icon(Icons.search, size: 30, color: Colors.white,),
                Icon(Icons.settings, size: 30, color: Colors.white,),
              ],
              onTap: (index) => _goToTab(index),
            ),
          )
        ],
      ),
    );
  }

  /// Update the screen to the current index 
  _goToTab(int index) {
    hideKeyboard(context);
                
    setState(() {
      _currentNavIndex = index;
    });
  }
}