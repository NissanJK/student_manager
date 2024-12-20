import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_manager/Model/info.dart';

class DatabaseHelper {
  // Database constants
  static const databaseName = "info.db";
  static const databaseVersion = 1;
  static const tableInfo = 'student_info';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnStudentID = 'student_id';
  static const columnPhone = 'phone';
  static const columnEmail = 'email';
  static const columnLocation = 'location';

  // Singleton instance
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // Getter for database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _createTables,
    );
  }

  // Create tables
  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableInfo (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT,
        $columnStudentID TEXT NOT NULL,
        $columnPhone TEXT,
        $columnEmail TEXT,
        $columnLocation TEXT
      )
    ''');
  }

  // Insert data
  Future<int> insertData(Info info) async {
    Database db = await instance.database;
    return await db.insert(tableInfo, info.toMap());
  }

  // Get all data
  Future<List<Map<String, dynamic>>> getAllData() async {
    Database? db = await instance.database;

    return await db.query(tableInfo, orderBy: "$columnId DESC");

    // Use rawQuery to select all notes
    // List<Map<String, dynamic>> notes = await db!.rawQuery('SELECT * FROM notes');

    //return notes;
  }


  // Update data
  Future<int> updateData(Info info, int id) async {
    Database? db = await instance.database;

    return await db!
        .update(tableInfo, info as Map<String, Object?>, where: '$columnId = ?', whereArgs: [id]);

    // await db.rawQuery(
    //     'SELECT * FROM notes WHERE userId = ?',
    //     [userId]);

  }

  // Delete data
  Future<int> deleteData(int id) async {
    Database db = await instance.database;
    return await db.delete(
      tableInfo,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
