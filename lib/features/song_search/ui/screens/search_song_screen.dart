import 'package:flutter/material.dart';
import 'package:lyrics/features/song_search/data/datasources/song_search_api.dart';
import 'package:lyrics/features/song_search/ui/widgets/empty_query_widget.dart';
import 'package:lyrics/features/song_search/ui/widgets/search_results_list.dart';
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
            child: _currentQuery.isEmpty ? buildEmptyQueryWidget() : buildSearchResults(_currentQuery),
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

  Widget buildEmptyQueryWidget() {
    return EmptyQueryWidget();
  }

  Widget buildSearchResults(String query) {
    final songs = deezerApi.search(query);
    return SearchResultsList(futureSongs: songs);
  }
}