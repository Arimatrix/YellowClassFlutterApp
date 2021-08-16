import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:android_projects/models/movie.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String movieTable = 'movie_table';
  String colId = 'id';
  String colName = 'name';
  String colDirector = 'director';
  DatabaseHelper._createInstance();

  factory DatabaseHelper()
  {
    if(_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;

  }
  Future<Database> get database async{
    if(_database == null)
      {
        _database = await initializeDatabase();
      }
    return _database;

  }
  Future<Database> initializeDatabase() async
  {
    Directory directory = await getApplicationDocumentsDirectory();
    String path=directory.path+'movie.db';
    var movieDatabase = await openDatabase(path,version:1,onCreate: _createDb);
    return movieDatabase;
  }
  void _createDb(Database db, int newVersion) async
  {
    await db.execute('CREATE TABLE $movieTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT,'
        '$colDirector TEXT)');
  }
  //CRUD operations
  Future<List<Map<String,dynamic>>>getMovieMapList() async
  {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $movieTable order by $colName ASC');
    return result;
  }
  Future<int> insertMovie(Movie movie) async {
   Database db = await this.database;
   var result = await db.insert(movieTable, movie.toMap());
   return result;

  }
  Future<int> updateMovie(Movie movie) async {
    var db = await this.database;
    var result = await db.update(movieTable, movie.toMap(), where: '$colId = ?', whereArgs: [movie.id]);
    return result;

  }
  Future<int> deleteMovie(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $movieTable WHERE $colId = $id');
    return result;

  }
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String,dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $movieTable');
    int result = Sqflite.firstIntValue(x);
    return result;

  }
  Future<List<Movie>> getMovieList() async
  {
    var movieMapList = await getMovieMapList();
    int count = movieMapList.length;
    List<Movie> movieList = List<Movie>();
    for(int i=0;i<count;i++)
      {
        movieList.add(Movie.fromMapObject(movieMapList[i]));

      }
    return movieList;


  }

}

