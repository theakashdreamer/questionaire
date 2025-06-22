import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/user_model.dart';
import 'db_constants.dart';

class DBService {
  static final DBService _instance = DBService._internal();
  factory DBService() => _instance;
  DBService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), DBConstants.dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DBConstants.userTable} (
        ${DBConstants.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DBConstants.columnEmail} TEXT NOT NULL,
        ${DBConstants.columnPassword} TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(table, data);
  }

  Future<List<Map<String, dynamic>>> select({
    required String table,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await database;
    return await db.query(table, where: where, whereArgs: whereArgs);
  }

  Future<int> delete({
    required String table,
    required String where,
    required List<Object?> whereArgs,
  }) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<void> clearTable(String table) async {
    final db = await database;
    await db.delete(table);
  }
}
