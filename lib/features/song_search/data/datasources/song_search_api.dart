import 'package:flutter_core/web/base_api.dart';
import 'package:lyrics/features/song_search/data/models/all_genres_model.dart';
import 'package:lyrics/features/song_search/data/models/genre_data_model.dart';
import 'package:lyrics/features/song_search/data/models/search_result_model.dart';
import 'package:lyrics/features/song_search/data/models/song_model.dart';

final deezerApi = SongSearchApi();

class SongSearchApi extends BaseApi {
  SongSearchApi() : super('api.deezer.com');

  Future<List<SongModel>> search(String query) async {
    final map = { 'q':query };
    final result = await fetchJSON('search', map);
    final searchData = SearchResultModel.fromJson(result);
    return searchData.data;
  }

  Future<List<GenreDataModel>> getAllGenres() async {
    final result = await fetchJSON('genre');
    final genreData = AllGenresModel.fromJson(result);
    return genreData.data;
  }

  Future<List<SongModel>> getGenreCharts(int genreId) async {
    final params = { 'limit':'100' };
    final result = await fetchJSON('chart/$genreId/tracks', params);
    final genreData = SearchResultModel.fromJson(result);
    return genreData.data;
  }
}