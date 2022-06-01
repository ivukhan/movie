import 'package:movie/models/movies.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const String _createTableMovie = '''create table $tblMovie(
  $tblMovieColId integer primary key autoincrement,
  $tblMovieColName text,
  $tblMovieColSubtitle text,
  $tblMovieColType text,
  $tblMovieColDescription text,
  $tblMovieColImage text,
  $tblMovieColRating real,
  $tblMovieColReleaseDate integer)''';

  static Future<Database> open() async {
    final rootPath = await getDatabasesPath();
    final dbPath = Path.join(rootPath, 'movie.db');
    return openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.execute(_createTableMovie);
    });
  }

  static Future<int> insertMovie(Movie movie) async {
    final db = await open();
    return db.insert(tblMovie, movie.toMap());
  }

  static Future<List<Movie>> getAllMovies() async {
    final db = await open();
    final mapList = await db.query(tblMovie);
    return List.generate(mapList.length, (index) => Movie.fromMap(mapList[index]));
  }
}