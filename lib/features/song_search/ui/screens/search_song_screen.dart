import 'package:flutter/material.dart';
import 'package:flutter_core/ui/widgets/center_progress_indicator.dart';
import 'package:flutter_core/ui/widgets/center_text.dart';
import 'package:lyrics/features/song_search/data/datasources/deezer_api.dart';
import 'package:lyrics/features/song_search/data/models/song_data_model.dart';
import 'package:lyrics/features/song_search/ui/widgets/song_list_tile.dart';
import 'package:lyrics/features/song_search/ui/widgets/song_search_bar.dart';

// Search API:
// https://api.deezer.com/search?q=rammstein%20sonne&limit=5

// Lyrics API:
// https://api.lyrics.ovh/v1/rammstein/sonne

class SearchSongScreen extends StatefulWidget {
  @override
  _SearchSongScreenState createState() => _SearchSongScreenState();
}

class _SearchSongScreenState extends State<SearchSongScreen> {
  final _api = DeezerApi();
  String _currentQuery = '';
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          SongSearchBar(
            onChanged: (text) => onTextChange(text),
          ),
          Expanded(
            child: buildSearchResults(_currentQuery),
          ),
        ],
      ),
    );
  }

  onTextChange(String text) {
    setState(() {
      _currentQuery = text;
    });
  }

  Widget buildSearchResults(String query) {
    final songs = _api.search(query);

    return FutureBuilder<List<SongModel>>(
      future: songs,
      builder: (BuildContext context, AsyncSnapshot<List<SongModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final widgetList = <Widget>[];

          // Inform user when no data has been found
          if (snapshot.data == null || snapshot.data.isEmpty) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 90),
              child: CenterText('Nothing found'),
            );
          }

          // Create ListTiles from the song datw
          snapshot.data.forEach((song) => widgetList.add(
            SongListTile(song: song)
          ));

          // Build a list of the fetched data
          return ListView.builder(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 90),
            itemCount: widgetList.length,
            itemBuilder: (context, index) {
              return widgetList[index];
            }
          );
        }

        // Show progress indicator when search results aren't available
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 90),
          child: CenterProgressIndicator(),
        );
      },
    );
  }
}