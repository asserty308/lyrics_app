class LyricsModel {
  String lyrics;

  LyricsModel({this.lyrics});

  LyricsModel.fromJson(Map<String, dynamic> json) {
    lyrics = json['lyrics'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lyrics'] = this.lyrics;
    return data;
  }
}
