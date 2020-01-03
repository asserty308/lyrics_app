import 'package:flutter/material.dart';
import 'package:lyrics/features/song_search/data/datasources/deezer_api.dart';
import 'package:lyrics/features/song_search/data/models/genre_data_model.dart';
import 'package:lyrics/features/song_search/data/models/song_data_model.dart';

class EmptyQueryWidget extends StatefulWidget {
  @override
  _EmptyQueryWidgetState createState() => _EmptyQueryWidgetState();
}

class _EmptyQueryWidgetState extends State<EmptyQueryWidget> {
  final _api = DeezerApi();

  var _genres = <GenreDataModel>[];
  var _latestSongs = <SongModel>[];

  Widget get _latestSearches {
    return Column(
      children: <Widget>[
        Text(
          'Latest searches',
          style: Theme.of(context).textTheme.headline,
        ),
      ],
    );
  }

  Widget get _charts {
    return Column(
      children: <Widget>[
        Text(
          'Search charts',
          style: Theme.of(context).textTheme.headline,
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
              return Card(
                clipBehavior: Clip.antiAliasWithSaveLayer, // prevents children from overlapping
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: Colors.blueAccent,
                child: Stack(
                  children: <Widget>[
                    Image.network(_genres[index].pictureMedium),
                    Container(color: Colors.black26,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          _genres[index].name,
                          style: Theme.of(context).textTheme.headline.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
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
    _genres = await _api.getAllGenres();
    setState(() {});
  }
}