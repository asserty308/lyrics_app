import 'package:flutter/material.dart';
import 'package:flutter_core/ui/widgets/center_progress_indicator.dart';
import 'package:flutter_core/ui/widgets/center_text.dart';
import 'package:flutter_core/utility/keyboard.dart';
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
            child: showSearchResults(_currentQuery),
          )
        ],
      ),
    );
  }

  onTextChange(String text) {
    setState(() {
      _currentQuery = text;
    });
  }

  Widget showSearchResults(String query) {
    final songs = _api.search(query);

    return FutureBuilder<List<SongModel>>(
      future: songs,
      builder: (BuildContext context, AsyncSnapshot<List<SongModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final widgetList = <Widget>[];

          if (snapshot.data == null) {
            return CenterText('Nothing found');
          }

          for (final song in snapshot.data) {
            widgetList.add(
              SongListTile(song: song)
            );
          }

          return ListView.builder(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 90),
            itemCount: widgetList.length,
            itemBuilder: (context, index) {
              return widgetList[index];
            }
          );
        }

        // show progress indicator when search results aren't available
        return CenterProgressIndicator();
      },
    );
  }
}