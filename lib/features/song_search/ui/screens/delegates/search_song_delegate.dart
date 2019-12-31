import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/ui/widgets/center_progress_indicator.dart';
import 'package:flutter_core/ui/widgets/center_text.dart';
import 'package:lyrics/features/song_search/data/datasources/deezer_api.dart';
import 'package:lyrics/features/song_search/data/models/song_data_model.dart';
import 'package:lyrics/features/song_search/ui/widgets/song_list_tile.dart';

class SearchSongDelegate extends SearchDelegate {
  final _api = DeezerApi();

  @override
  List<Widget> buildActions(BuildContext context) {
    // add a 'clear query' button
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // show a back button to close the search
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => SystemNavigator.pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) => showSearchResults();

  @override
  Widget buildSuggestions(BuildContext context) => showSearchResults();

  Widget showSearchResults() {
    final songs = _api.search(query);

    return FutureBuilder<List<SongModel>>(
      future: songs,
      builder: (BuildContext context, AsyncSnapshot<List<SongModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final widgetList = <Widget>[];

          if (snapshot.data == null) {
            return CenterText('Nothing found');
          }

          for (final song in snapshot.data) {
            widgetList.add(
              SongListTile(song: song)
            );
          }

          return ListView.builder(
            itemCount: widgetList.length,
            itemBuilder: (context, index) {
              return widgetList[index];
            }
          );
        }

        // show progress indicator when search results aren't available
        return CenterProgressIndicator();
      },
    );
  }
}