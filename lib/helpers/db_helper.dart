import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  static Future<Database> getDatabase() async {
    final dbPath = await sql.getDatabasesPath(); // getting db path
    // opening db and implementing onCreate to construct the table
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)',
      );
    }, version: 1);
  }

  // insert data to the sqlite database
  static Future<void> insert(String table, Map<String, Object> data) async {
    // inserting data to db
    final db = await DbHelper.getDatabase();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  // fetch data from the database
  static Future<List<Map<String, Object>>> getPlaces(String table) async {
    final db = await DbHelper.getDatabase();
    return db.query(table);
  }
}
