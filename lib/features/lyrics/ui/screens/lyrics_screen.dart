import 'package:flutter/material.dart';
import 'package:flutter_core/cloud_translation/data/translation_api.dart';
import 'package:flutter_core/ui/widgets/center_progress_indicator.dart';
import 'package:flutter_core/ui/widgets/center_text.dart';
import 'package:flutter_core/i18n/context_localization.dart';
import 'package:lyrics/core/i18n/localization_helper.dart';
import 'package:lyrics/features/favorites/data/datasources/favorites_table_provider.dart';
import 'package:lyrics/features/lyrics/data/datasources/lyrics_api.dart';
import 'package:lyrics/features/song_search/data/models/song_model.dart';

class LyricsScreen extends StatefulWidget {
  LyricsScreen({this.song});

  final SongModel song;

  @override
  _LyricsScreenState createState() => _LyricsScreenState();
}

class _LyricsScreenState extends State<LyricsScreen> {
  final _lyricsApi = LyricsApi();
  final _translationApi = TranslationApi();
  var _originalLyrics = '';
  var _translatedLyrics = '';
  var _showTranslation = false;
  var _isFavorite = false;

  String get _displayedLyrics {
    return _showTranslation ? _translatedLyrics : _originalLyrics;
  }

  AppBar get _appBar {
    return AppBar(
      title: Text('${widget.song.title}'),
      backgroundColor: Color.fromARGB(255, 1, 1, 1),
      actions: <Widget>[
        IconButton(
          icon: _isFavorite ? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite_border, color: Colors.white,),
          onPressed: () => _favoriteButtonPressed(),
        ),
        IconButton(
          icon: Icon(Icons.translate, color: _showTranslation ? Colors.blue : Colors.white),
          onPressed: () => _toggleTranslation(),
        )
      ],
    );
  }

  /// Screen body handles different states: Error, Loading and ShowLyrics
  Widget get _body {
    if (_displayedLyrics == null) {
      return CenterText(context.localize('error_occured'));
    }

    if (_displayedLyrics.isEmpty) {
      return CenterProgressIndicator();
    }
    
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 90), // content inset
      child: CenterText(
        _displayedLyrics,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeUI();
    _fetchAndTranslate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }

  _initializeUI() async {
    // favorite state
    _isFavorite = await FavoritesTableProvider.table.contains(widget.song);
    setState(() {});
  }

  /// Fetch lyrics, translate lyrics
  _fetchAndTranslate() async {
    // lyrics
    final result = await _lyricsApi.fetchLyrics(widget.song.artist.name, widget.song.title);

    if (result == null) {
      setState(() {
        _originalLyrics = null;
        _translatedLyrics = null;
      });
      return;
    }

    // translate
    _originalLyrics = result.lyrics;
    await _translateLyrics();

    setState(() {});
  }

  _translateLyrics() async {
    var response = await _translationApi.translateText(_originalLyrics, MyLocalization.deviceLocale);

    if (response == null || response.isEmpty) {
      response = context.localize('error_occured');
    }

    _translatedLyrics = response;
  }

  _toggleTranslation() {
    setState(() {
      _showTranslation = !_showTranslation;
    });
  }

  _favoriteButtonPressed() async {
    _isFavorite = !_isFavorite;
    
    if (_isFavorite) {
      // add
      await FavoritesTableProvider.table.insert(widget.song);
    } else {
      // remove
      await FavoritesTableProvider.table.delete(widget.song);
    }

    setState(() {});
  }
}