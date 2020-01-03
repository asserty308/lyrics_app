import 'package:lyrics/features/song_search/data/models/album_model.dart';
import 'package:lyrics/features/song_search/data/models/artist_model.dart';

class SongModel {
  int id;
  bool readable;
  String title;
  String titleShort;
  String titleVersion;
  String link;
  int duration;
  int rank;
  bool explicitLyrics;
  int explicitContentLyrics;
  int explicitContentCover;
  String preview;
  ArtistModel artist;
  AlbumModel album;
  String type;

  SongModel({
    this.id,
    this.readable,
    this.title,
    this.titleShort,
    this.titleVersion,
    this.link,
    this.duration,
    this.rank,
    this.explicitLyrics,
    this.explicitContentLyrics,
    this.explicitContentCover,
    this.preview,
    this.artist,
    this.album,
    this.type
  });

  SongModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readable = json['readable'];
    title = json['title'];
    titleShort = json['title_short'];
    titleVersion = json['title_version'];
    link = json['link'];
    duration = json['duration'];
    rank = json['rank'];
    explicitLyrics = json['explicit_lyrics'];
    explicitContentLyrics = json['explicit_content_lyrics'];
    explicitContentCover = json['explicit_content_cover'];
    preview = json['preview'];
    artist =
        json['artist'] != null ? new ArtistModel.fromJson(json['artist']) : null;
    album = json['album'] != null ? new AlbumModel.fromJson(json['album']) : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['readable'] = this.readable;
    data['title'] = this.title;
    data['title_short'] = this.titleShort;
    data['title_version'] = this.titleVersion;
    data['link'] = this.link;
    data['duration'] = this.duration;
    data['rank'] = this.rank;
    data['explicit_lyrics'] = this.explicitLyrics;
    data['explicit_content_lyrics'] = this.explicitContentLyrics;
    data['explicit_content_cover'] = this.explicitContentCover;
    data['preview'] = this.preview;
    if (this.artist != null) {
      data['artist'] = this.artist.toJson();
    }
    if (this.album != null) {
      data['album'] = this.album.toJson();
    }
    data['type'] = this.type;
    return data;
  }
}