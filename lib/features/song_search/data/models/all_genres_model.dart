import 'package:lyrics/features/song_search/data/models/genre_data_model.dart';

class AllGenresModel {
  List<GenreDataModel> data;

  AllGenresModel({this.data});

  AllGenresModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GenreDataModel>[];
      json['data'].forEach((v) {
        data.add(new GenreDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
