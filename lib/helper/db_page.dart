
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../global.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper dbHelper = DBHelper._();

  final String dbname = "life.db";
  final String tableName = "quotesTable";
  final String colQuotes = "";
  final String colId = "id";

  Database? db;

  Future<void> initDB() async {
    String directory = await getDatabasesPath();
    String path = join(directory, dbname);

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          String query =
              "CREATE TABLE IF NOT EXISTS $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colQuotes TEXT)";

          await db.execute(query);
        });
  }

  Future<int?> insertRecord({required String name}) async {
    await initDB();

    String query = "INSERT INTO $tableName($colQuotes) VALUES(?)";
    List demo = [name];
    int? id = await db?.rawInsert(query, demo);

    return id;
  }

  Future fetchRecord() async {
    await initDB();
    Globle.favoriteList = [];

    String query = "SELECT * FROM $tableName";

    List data = await db!.rawQuery(query);

    Globle.favoriteList = data;
  }

  Future<int> deleteRocord({required String name}) async {
    await initDB();

    String query = "DELETE FROM $tableName WHERE $colQuotes = ?";
    List demo = [name];

    return db!.rawDelete(query, demo);
  }
}