import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ui/widgets/center_progress_indicator.dart';
import 'package:flutter_core/ui/widgets/center_text.dart';
import 'package:lyrics/features/lyrics/data/datasources/lyrics_api.dart';

class LyricsScreen extends StatefulWidget {
  LyricsScreen({this.artist, this.song});

  final String artist, song;

  @override
  _LyricsScreenState createState() => _LyricsScreenState();
}

class _LyricsScreenState extends State<LyricsScreen> {
  final _api = LyricsApi();
  var _lyrics = '';

  @override
  void initState() {
    super.initState();
    fetchLyrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.artist} - ${widget.song}'),
      ),
      body: Stack(
        children: <Widget>[ 
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 90), // content inset
              child: _lyrics.isEmpty ? CenterProgressIndicator() : CenterText(
                _lyrics,
                style: Theme.of(context).textTheme.title,
              ),
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

              },
            ),
          )
        ],
      ),
    );
  }

  fetchLyrics() async {
    final result = await _api.fetchLyrics(widget.artist, widget.song);

    setState(() {
      _lyrics = result.lyrics ?? 'No lyrics found';
    });
  }
}