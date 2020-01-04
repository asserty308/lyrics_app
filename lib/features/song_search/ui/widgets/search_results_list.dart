import 'package:flutter/material.dart';
import 'package:flutter_core/i18n/context_localization.dart';
import 'package:flutter_core/ui/widgets/center_progress_indicator.dart';
import 'package:flutter_core/ui/widgets/center_text.dart';
import 'package:lyrics/features/song_search/data/models/song_model.dart';
import 'package:lyrics/features/song_search/ui/widgets/song_list_tile.dart';

class SearchResultsList extends StatelessWidget {
  SearchResultsList({
    this.futureSongs,
  });

  final Future<List<SongModel>> futureSongs;
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: futureSongs,
      builder: (BuildContext context, AsyncSnapshot<List<SongModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final widgetList = <Widget>[];

          // Inform user when no data has been found
          if (snapshot.data == null || snapshot.data.isEmpty) {
            return CenterText(context.localize('nothing_found'));
          }

          // Create ListTiles from the song datw
          snapshot.data.forEach((song) => widgetList.add(
            SongListTile(song: song)
          ));

          // Build a list of the fetched data
          return ListView.builder(
            itemCount: widgetList.length,
            itemBuilder: (context, index) {
              return widgetList[index];
            }
          );
        }

        // Show progress indicator when search results aren't available
        return CenterProgressIndicator();
      },
    );
  }
}