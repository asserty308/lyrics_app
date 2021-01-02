import 'package:flutter/material.dart';
import 'package:flutter_core/i18n/context_localization.dart';
import 'package:flutter_core/routing/routing.dart';
import 'package:lyrics/features/song_search/data/datasources/deezer_api.dart';
import 'package:lyrics/features/song_search/data/models/genre_data_model.dart';
import 'package:lyrics/features/song_search/data/models/song_model.dart';
import 'package:lyrics/features/song_search/ui/screens/charts_screen.dart';

class EmptyQueryWidget extends StatefulWidget {
  @override
  _EmptyQueryWidgetState createState() => _EmptyQueryWidgetState();
}

class _EmptyQueryWidgetState extends State<EmptyQueryWidget> {
  var _genres = <GenreDataModel>[];
  var _latestSongs = <SongModel>[];

  Widget get _latestSearches {
    return _latestSongs.isEmpty ? Container() : Column(
      children: <Widget>[
        Text(
          context.localize('latest_searches'),
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }

  Widget get _charts {
    return Column(
      children: <Widget>[
        Text(
          context.localize('search_charts'),
          style: Theme.of(context).textTheme.headline5,
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: GridView.count(
            shrinkWrap: true, // needed because child of SingleChildScrollView
            physics: NeverScrollableScrollPhysics(), // needed because child of SingleChildScrollView
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            crossAxisCount: 2,
            children: List.generate(_genres.length, (index) {
              final genre = _genres[index];

              return InkWell(
                onTap: () => showScreen(context, ChartsScreen(
                  genreId: genre.id, 
                  genreName: genre.name
                )),
                child: buildGenreCard(genre),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget buildGenreCard(GenreDataModel genre) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer, // prevents children from overlapping
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: <Widget>[
          Image.network(genre.pictureMedium),
          Container(color: Colors.black26,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                genre.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchGenres();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 90),
      child: Column(
        children: <Widget>[
          _latestSearches,
          SizedBox(height: 24,),
          _charts,
        ],
      ),
    );
  }

  _fetchGenres() async {
    _genres = await deezerApi.getAllGenres();
    setState(() {});
  }
}