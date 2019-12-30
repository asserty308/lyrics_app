import 'package:flutter_core/web/base_api.dart';
import 'package:lyrics/features/song_search/data/models/deezer_response_model.dart';
import 'package:lyrics/features/song_search/data/models/song_data_model.dart';

class DeezerApi {
  final _api = BaseApi('api.deezer.com');

  /// Wrapper to fetch JSON from the API
  Future<dynamic> fetchJSON(String path, Map<String, String> query) async {
    return _api.fetchJSON(path, query);
  }

  Future<List<SongModel>> search(String query) async {
    final map = { 'q':query };
    final result = await fetchJSON('search', map);
    final deezerData = DeezerResponseModel.fromJson(result);
    return deezerData.data;
  }
}