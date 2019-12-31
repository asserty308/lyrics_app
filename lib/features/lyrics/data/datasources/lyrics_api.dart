import 'package:flutter_core/web/base_api.dart';
import 'package:lyrics/features/lyrics/data/models/lyrics_model.dart';

class LyricsApi extends BaseApi {
  LyricsApi() : super('https://api.lyrics.ovh/v1/');
  
  Future<LyricsModel> fetchLyrics(String artist, String song) async {
    final result = await fetchJSON('$artist/$song');
    return LyricsModel.fromJson(result);
  }
}