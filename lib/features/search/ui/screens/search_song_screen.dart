import 'package:flutter/material.dart';
import 'package:lyrics/features/search/data/datasources/deezer_api.dart';

// Search API:
// https://api.deezer.com/search?q=rammstein%20sonne&limit=5

// Lyrics API:
// https://api.lyrics.ovh/v1/rammstein/sonne

class SearchSongScreen extends StatefulWidget {
  @override
  _SearchSongScreenState createState() => _SearchSongScreenState();
}

class _SearchSongScreenState extends State<SearchSongScreen> {
  final _api = DeezerAPI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter song title',
              style: Theme.of(context).textTheme.display1,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Artist - Song'
                ),
              ),
            ),
            FloatingActionButton(
              child: Icon(Icons.search),
              onPressed: () async {
                final map = { 'q':'rammstein' };
                final result = await _api.fetchJSON('search', map);
                print(result);
              },
            )
          ],
        ),
      ),
    );
  }
}