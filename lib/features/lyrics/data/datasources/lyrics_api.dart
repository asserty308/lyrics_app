import 'package:flutter_core/web/base_api.dart';
import 'package:lyrics/features/lyrics/data/models/lyrics_model.dart';

class LyricsApi extends BaseApi {
  LyricsApi() : super('https://api.lyrics.ovh/v1/');
  
  Future<LyricsModel> fetchLyrics(String artist, String song) async {
    // remove '/' as it builds an invalid request
    artist = artist.replaceAll('/', '').replaceAll('?', '').replaceAll('&', '');
    song = song.replaceAll('/', '').replaceAll('?', '').replaceAll('&', '');

    try {
      final result = await fetchJSON('$artist/$song');
      return LyricsModel.fromJson(result);
    } catch (e) {
      return null;
    }
  }
}