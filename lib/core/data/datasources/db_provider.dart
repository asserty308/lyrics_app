import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Provides acces to the app's database.
/// 
/// You can access the [database] from everywhere by calling [MyDatabaseProvider.db.database].
/// Use this class to update and upgrade the database.
class MyDatabaseProvider {
  // private constructor
  MyDatabaseProvider._();

  // static access
  static final MyDatabaseProvider db = MyDatabaseProvider._();

  // private members
  Database _database;
  final int _version = 1;

  /// Singleton access to the database instance
  Future<Database> get database async {
    if (_database != null)
      return _database;

    _database = await _createDatabaseInstance();
    return _database;
  }

  Future<Database> _createDatabaseInstance() async {
    String path = join(await getDatabasesPath(), 'app_db.db');
    
    return await openDatabase(
      path,
      // When the database is first created, create the necessary tables.
      onCreate: (db, version) async {
        // create table for favorites
        await db.execute("CREATE TABLE Favorites(id INTEGER PRIMARY KEY, artist TEXT, song TEXT, album TEXT, cover_url TEXT)");
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: _version,
    );
  }
}