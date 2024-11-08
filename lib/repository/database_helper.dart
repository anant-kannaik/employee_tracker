import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final sharedInstance = DatabaseHelper._();
  DatabaseHelper._();

  static const _databaseName = "employee_database.db";
  static const _databaseVersion = 1;

  static const table = 'employee';

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table (id INTEGER PRIMARY KEY, name TEXT, role TEXT, fromDate TEXT, toDate TEXT)');
  }
}
