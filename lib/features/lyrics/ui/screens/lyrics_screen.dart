import 'package:flutter/material.dart';
import 'package:flutter_core/modules/translation/data/translation_api.dart';
import 'package:flutter_core/ui/widgets/center_progress_indicator.dart';
import 'package:flutter_core/ui/widgets/center_text.dart';
import 'package:lyrics/features/lyrics/data/datasources/lyrics_api.dart';
import 'package:lyrics/main.dart';

class LyricsScreen extends StatefulWidget {
  LyricsScreen({this.artist, this.song});

  final String artist, song;

  @override
  _LyricsScreenState createState() => _LyricsScreenState();
}

class _LyricsScreenState extends State<LyricsScreen> {
  final _lyricsApi = LyricsApi();
  final _translationApi = TranslationApi();
  var _originalLyrics = '';
  var _translatedLyrics = '';
  var _showTranslation = false;

  String get _displayedLyrics {
    return _showTranslation ? _translatedLyrics : _originalLyrics;
  }

  AppBar get _appBar {
    return AppBar(
      title: Text('${widget.song}'),
      backgroundColor: Color.fromARGB(255, 1, 1, 1),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.favorite_border, color: Colors.white,),
          onPressed: () {
          },
        ),
        IconButton(
          icon: Icon(Icons.translate, color: _showTranslation ? Colors.blue : Colors.white),
          onPressed: () => _toggleTranslation(),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchLyrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _displayedLyrics.isEmpty ? CenterProgressIndicator() : SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 90), // content inset
        child: CenterText(
          _displayedLyrics,
          style: Theme.of(context).textTheme.title,
        ),
      ),
    );
  }

  _fetchLyrics() async {
    final result = await _lyricsApi.fetchLyrics(widget.artist, widget.song);
    _originalLyrics = result.lyrics;
    await _translateLyrics();

    setState(() {
    });
  }

  _translateLyrics() async {
    var response = await _translationApi.translateText(_originalLyrics, globalDeviceLocale);

    if (response == null || response.isEmpty) {
      response = 'An error occured';
    }

    _translatedLyrics = response;
  }

  _toggleTranslation() {
    setState(() {
      _showTranslation = !_showTranslation;
    });
  }
}