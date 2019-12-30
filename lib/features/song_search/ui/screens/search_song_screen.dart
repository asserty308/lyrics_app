import 'package:flutter/material.dart';
import 'package:lyrics/features/song_search/ui/screens/delegates/search_song_delegate.dart';

// Search API:
// https://api.deezer.com/search?q=rammstein%20sonne&limit=5

// Lyrics API:
// https://api.lyrics.ovh/v1/rammstein/sonne

class SearchSongScreen extends StatefulWidget {
  @override
  _SearchSongScreenState createState() => _SearchSongScreenState();
}

class _SearchSongScreenState extends State<SearchSongScreen> {
  @override
  void initState() {
    super.initState();

    // run 'afterFirstlayout' after first build()
    WidgetsBinding.instance.addPostFrameCallback((_) => _afterFirstlayout(context));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void _afterFirstlayout(BuildContext context) {
    showSearch(
      context: context,
      delegate: SearchSongDelegate()
    );
  }
}