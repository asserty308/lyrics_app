import 'package:flutter/material.dart';
import 'package:lyrics/features/song_search/data/datasources/deezer_api.dart';
import 'package:lyrics/features/song_search/ui/widgets/search_results_list.dart';

class ChartsScreen extends StatefulWidget {
  ChartsScreen({
    this.genreId,
    this.genreName,
  });

  final int genreId;
  final String genreName;

  @override
  _ChartsScreenState createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.genreName),
        backgroundColor: Colors.black,
      ),
      body: _buildSongList(),
    );
  }

  Widget _buildSongList() {
    final futureSongs = deezerApi.getGenreCharts(widget.genreId);
    return SearchResultsList(futureSongs: futureSongs,);
  }
}