import 'package:flutter/material.dart';
import 'package:flutter_core/utility/routing/routing.dart';
import 'package:lyrics/features/lyrics/ui/screens/lyrics_screen.dart';
import 'package:lyrics/features/song_search/data/models/song_model.dart';

class SongListTile extends StatelessWidget {
  const SongListTile({
    Key key,
    @required this.song,
  }) : super(key: key);

  final SongModel song;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${song.title}'),
      subtitle: Text('${song.artist.name} - ${song.album.title}'),
      leading: CircleAvatar(
        child: Image.network(song.album.coverSmall),
        backgroundColor: Colors.transparent,
      ),
      onTap: () {
        // show lyrics screen
        showScreen(context, LyricsScreen(
          artist: song.artist.name, 
          song: song.title,
        ));
      },
    );
  }
}