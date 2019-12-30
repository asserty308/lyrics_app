import 'dart:convert';

import 'package:http/http.dart';

class DeezerAPI {
  final _baseUrl = 'api.deezer.com';

  /// Wrapper to fetch JSON from the API
  Future<dynamic> fetchJSON(String path, Map<String, String> query) async {
    final url = Uri.https(_baseUrl, path, query);
    final response = await get(url);
    final statusCode = response.statusCode;

    if (statusCode != 200) {
      throw Exception('Received error $statusCode on url $url');
    }

    return json.decode(response.body);
  }
}