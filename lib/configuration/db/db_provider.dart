import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  // private 생성자를 통해서 static final DatabaseProvider 정적 인스턴스 생성
  static final DatabaseProvider _instance =
      DatabaseProvider._privateConstructor();

  static Database? _database;

  DatabaseProvider._privateConstructor();

  static DatabaseProvider get instance => _instance;

  Future<Database> get database async {
    //_database 변수가 null인 경우에만 _initDB() 함수를 호출
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'zero_bug.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE memos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            content TEXT,
            satisfaction TEXT,
            createdAt TEXT,
            stoppedAt TEXT
          )
        ''');
      },
    );
  }
}
