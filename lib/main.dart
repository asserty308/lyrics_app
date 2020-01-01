import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/utility/keyboard.dart';
import 'package:lyrics/features/favorites/ui/screens/favorites_screen.dart';
import 'package:lyrics/features/settings/ui/screens/settings_screen.dart';
import 'package:lyrics/features/song_search/ui/screens/search_song_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lyrics App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                color: Colors.blue,
                backgroundColor: Colors.transparent,
                items: <Widget>[
                  Icon(Icons.favorite, size: 30, color: Colors.white,),
                  Icon(Icons.search, size: 30, color: Colors.white,),
                  Icon(Icons.settings, size: 30, color: Colors.white,),
                ],
                onTap: (index) {
                  hideKeyboard(context);
                  
                  setState(() {
                    _currentNavIndex = index;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
