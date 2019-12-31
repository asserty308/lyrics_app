import 'package:flutter_core/web/base_api.dart';
import 'package:lyrics/features/song_search/data/models/deezer_response_model.dart';
import 'package:lyrics/features/song_search/data/models/song_data_model.dart';

class DeezerApi extends BaseApi {
  DeezerApi() : super('api.deezer.com');

  Future<List<SongModel>> search(String query) async {
    final map = { 'q':query };
    final result = await fetchJSON('search', map);
    final deezerData = DeezerResponseModel.fromJson(result);
    return deezerData.data;
  }
}