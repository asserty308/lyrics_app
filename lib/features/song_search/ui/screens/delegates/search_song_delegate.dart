import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/ui/widgets/center_text.dart';
import 'package:flutter_core/utility/routing/routing.dart';
import 'package:lyrics/features/lyrics/ui/screens/lyrics_screen.dart';
import 'package:lyrics/features/song_search/data/datasources/deezer_api.dart';
import 'package:lyrics/features/song_search/data/models/song_data_model.dart';

class SearchSongDelegate extends SearchDelegate {
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
    final api = DeezerApi();
    final songs = api.search(query);

    return FutureBuilder<List<SongModel>>(
      future: songs,
      builder: (BuildContext context, AsyncSnapshot<List<SongModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var widgetList = <Widget>[];

          if (snapshot.data == null) {
            return CenterText('Nothing found');
          }

          for (var song in snapshot.data) {
            widgetList.add(
              ListTile(
                title: Text('${song.artist.name} - ${song.title}'),
                subtitle: Text('${song.album.title}'),
                leading: CircleAvatar(
                  child: Image.network(song.album.coverMedium),
                  backgroundColor: Colors.transparent,
                ),
                onTap: () {
                  // show lyrics screen
                  showScreen(context, LyricsScreen(
                    artist: song.artist.name, 
                    song: song.title
                  ));
                },
              )
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
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}