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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.white,),
            onPressed: () {
            },
          )
        ],
      ),
      body: _lyrics.isEmpty ? CenterProgressIndicator() : SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 90), // content inset
        child: CenterText(
          _lyrics,
          style: Theme.of(context).textTheme.title,
        ),
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