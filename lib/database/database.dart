import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/details_model.dart';

class DBProvider {

  DBProvider._();
  static final DBProvider db = DBProvider._();


  // static late Database _database;
  String databaseName = 'likes.db';
  String favorites = 'Liked';

  // static Database _database;

  Future<Database> get database async {

    // if (_database != null)
    //   return _database;

    Database _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    var _db = await openDatabase(path, version: 1,
        onCreate: onCreate );
    return _db;
  }

  onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $favorites ("
            "track_id INTEGER PRIMARY KEY,"
            "track_name TEXT,"
            "track_rating INTEGER,"
            "explicit INTEGER,"
            "album_name TEXT,"
            "artist_name TEXT"
            ")");
  }
  getFavorites(int id) async{
    final db = await database;
    var res = await db.query(favorites, where: "track_id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Track.fromMap(res.first) : Null;
  }

  newTrack(Track track)async{
    final db = await database;
    var res = await db.insert(favorites, track.toMap()
    );
    return res;
  }
  deleteTrack(int id)async{
    var db = await database;
    db.delete(favorites, where: "id = ?", whereArgs: [id]);
  }

  deleteAll()async{
    final db = await database;
    db.rawDelete("DELETE FROM $favorites");
  }

  Future<List<Track>>getAllTrack()async{
    final db = await database;
    var res = await db.query(favorites);
    List<Track> list = res.isNotEmpty ? res.map((e) => Track.fromMap(e)).toList() : [];
    return list;
  }
}

