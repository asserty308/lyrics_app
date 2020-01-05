import 'package:lyrics/core/data/datasources/db_provider.dart';
import 'package:lyrics/features/song_search/data/models/album_model.dart';
import 'package:lyrics/features/song_search/data/models/artist_model.dart';
import 'package:lyrics/features/song_search/data/models/song_model.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesTableProvider {
  // private constructor
  FavoritesTableProvider._();

  // static access
  static final FavoritesTableProvider table = FavoritesTableProvider._();

  Map<String, dynamic> _songToDbEntry(SongModel song) {
    return {
      'id': song.id,
      'artist': song.artist.name,
      'song': song.title,
      'album': song.album.title,
      'cover_url': song.album.coverSmall
    };
  }

  SongModel _dbEntryToSong(Map<String, dynamic> entry) {
    return SongModel(
      id: entry['id'],
      title: entry['song'],
      artist: ArtistModel(name: entry['artist']),
      album: AlbumModel(title: entry['album'], coverSmall: entry['cover_url']),
    );
  }

  Future insert(SongModel song) async {
    final db = await MyDatabaseProvider.db.database;
    final map = _songToDbEntry(song);

    await db.insert(
      'Favorites', 
      map,
      conflictAlgorithm: ConflictAlgorithm.abort
    );
  }

  Future<bool> contains(SongModel song) async => await getWithId(song.id) != null;

  Future<SongModel> getWithId(int id) async {
    final db = await MyDatabaseProvider.db.database;
    final response = await db.query('Favorites', where: 'id = ?', whereArgs: [id]);
    return response.isNotEmpty ? _dbEntryToSong(response.first) : null;
  }

  Future<SongModel> getWithTitle(String title) async {
    final db = await MyDatabaseProvider.db.database;
    final response = await db.query('Favorites', where: 'song = ?', whereArgs: [title]);
    return response.isNotEmpty ? _dbEntryToSong(response.first) : null;
  }

  Future<List<SongModel>> getAll() async {
    final db = await MyDatabaseProvider.db.database;
    final List<Map<String, dynamic>> maps = await db.query('Favorites');

    return List.generate(maps.length, (i) {
      final entry = maps[i];
      return _dbEntryToSong(entry);
    });
  }

  Future<int> tableCount() async {
    final db = await MyDatabaseProvider.db.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM Favorites'));
  }

  Future update(SongModel song) async {
    final db = await MyDatabaseProvider.db.database;
    final map = _songToDbEntry(song);

    await db.update(
      'Favorites', 
      map,
      where: 'id = ?',
      whereArgs: [song.id]
    );
  }

  Future delete(SongModel song) async {
    final db = await MyDatabaseProvider.db.database;
    final id = song.id;
    await db.delete(
      'Favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<SongModel>> search(String query) async {
    final filteredSongs = List<SongModel>();
    final lowerQuery = query.toLowerCase();

    if (lowerQuery.isEmpty) {
      return filteredSongs;
    }

    // fetch all songs and filter
    final allSongs = await getAll();

    for (final song in allSongs) {
      if (song.title.toLowerCase().contains(lowerQuery) || 
          song.artist.name.toLowerCase().contains(lowerQuery) ||
          song.album.title.toLowerCase().contains(lowerQuery)) {
        filteredSongs.add(song);
      }
    }

    return filteredSongs;
  }
}