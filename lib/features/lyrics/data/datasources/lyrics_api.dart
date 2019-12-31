import 'package:flutter_core/web/base_api.dart';
import 'package:lyrics/features/lyrics/data/models/lyrics_model.dart';

class LyricsApi {
  final _api = BaseApi('https://api.lyrics.ovh/v1/');

  /// Wrapper to fetch JSON from the API
  Future<dynamic> fetchJSON(String path) async {
    return _api.fetchJSON(path);
  }
  
  Future<LyricsModel> fetchLyrics(String artist, String song) async {
    final result = await _api.fetchJSON('$artist/$song');
    return LyricsModel.fromJson(result);
  }
}