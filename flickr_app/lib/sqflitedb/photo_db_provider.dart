import 'package:sqflite/sqflite.dart';
import 'package:stajproje/entities/photoModel.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  String _photoTableName = "photo1";

  String columnid = "id";
  String columnowner = "owner";
  String columntitle = "title";
  String columndesc = "desc";
  String columnurl = "url";
  String columnisLiked = "isLiked";
  Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
      return _database;
    } else
      return _database;
  }

  Future<Database> initializeDatabase() async {
    String dbPath = join(await getDatabasesPath(), "photos.db");
    var notesDb = await openDatabase(dbPath, version: 2, onCreate: createDb);
    return notesDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $_photoTableName($columnid TEXT PRIMARY KEY,$columnowner TEXT,$columntitle TEXT,$columndesc TEXT,$columnurl TEXT,$columnisLiked INT)');
  }

// tüm db listeye dönüştürme
  Future<List<Photo>> getAllNotes() async {
    Database _database = await this.database;
    List<Map> photoMaps = await _database.query("$_photoTableName");
    return photoMaps.map((e) => Photo.fromJson(e)).toList();
  }

  Future<int> insert(Photo model) async {
    Database _database = await this.database;
    final photoMaps = await _database.insert(_photoTableName, model.toJson());
    return photoMaps;
  }

// istenilen id ye göre item sorgusu
  Future<Photo> getItem(int id) async {
    Database _database = await this.database;
    final photoMaps = await _database.query(
      _photoTableName,
      where: '$columnid = ?',
      columns: [columnid],
      whereArgs: [id],
    );
    if (photoMaps.isNotEmpty)
      return Photo.fromJson(photoMaps.first);
    else
      return null;
  }

  Future<int> deleteList(int id) async {
    Database _database = await this.database;
    final photoMaps = await _database.delete(
      _photoTableName,
      where: '$columnid=?',
      whereArgs: [id],
    );
    return photoMaps;
  }

  Future<void> closedb() async {
    await _database.close();
  }
}
