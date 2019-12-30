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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: SingleChildScrollView(
          child: _lyrics.isEmpty ? CenterProgressIndicator() : CenterText(_lyrics,
            style: Theme.of(context).textTheme.title,
          ),
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