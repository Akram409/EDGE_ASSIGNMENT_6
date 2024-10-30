import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {

  //database name
  static const databaseName = "student.db";

  //database version
  static const databaseVersion = 1;

  //table name
  static const tableNotes = 'student';

  //column names
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnNumber = 'number';
  static const columnEmail = 'email';
  static const columnLocation = 'location';


  //create a single instance of DatabaseHelper
  DatabaseHelper.privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper.privateConstructor();

  // Create a database object
  static Database? myDb;


  //for initializing the database
  Future<Database?> get database async {
    if (myDb != null) return myDb;
    myDb = await initDatabase();
    return myDb;
  }


  //for initializing the database path
  initDatabase() async {
    // find the path to the databases directory on the device
    String path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(
        path,
        version: databaseVersion,
        onCreate: createTables
    );
  }


  //for creating table in database  if not exist already
  Future createTables(Database db, int version) async {
    await db.execute("""
          CREATE TABLE $tableNotes (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnNumber TEXT NOT NULL,
            $columnEmail TEXT NOT NULL,
            $columnLocation TEXT NOT NULL
          )
          """);
  }

  //for get data from database
  Future<List<Map<String, dynamic>>> getAllStudentData() async {
    Database? db = await instance.database;

    return await db!.query(tableNotes, orderBy: "$columnId DESC");

    // Use rawQuery to select all notes
    // List<Map<String, dynamic>> notes = await db!.rawQuery('SELECT * FROM notes');

    //return notes;
  }

  //for insert data in database
  Future<int> insertData(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(tableNotes, row);
  }

  //for update data in database
  Future<int> updateData(Map<String, dynamic> row,int id) async {
    Database? db = await instance.database;

    return await db!
        .update(tableNotes, row, where: '$columnId = ?', whereArgs: [id]);

    // await db.rawQuery(
    //     'SELECT * FROM notes WHERE userId = ?',
    //     [userId]);

  }

  //for delete data from database
  Future<int> deleteData(int id) async {
    Database? db = await instance.database;
    return await db!
        .delete(tableNotes, where: '$columnId = ?', whereArgs: [id]);
  }
}