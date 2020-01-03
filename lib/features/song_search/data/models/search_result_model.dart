import 'package:lyrics/features/song_search/data/models/song_data_model.dart';

class SearchResultModel {
  List<SongModel> data;
  int total;
  String next;

  SearchResultModel({
    this.data, 
    this.total, 
    this.next
  });

  SearchResultModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<SongModel>();
      json['data'].forEach((v) {
        data.add(new SongModel.fromJson(v));
      });
    }
    total = json['total'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['next'] = this.next;
    return data;
  }
}
