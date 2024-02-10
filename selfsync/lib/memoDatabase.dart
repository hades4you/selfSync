import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MemoDatabase {
  static Database? _database;
  static final String tableName = 'memos';
  static final String columnId = 'id';
  static final String columnTitle = 'title';
  static final String columnContent = 'content';

  MemoDatabase._privateConstructor();
  static final MemoDatabase instance = MemoDatabase._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'memos_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTitle TEXT,
            $columnContent TEXT
          )
          ''',
        );
      },
    );
  }

  Future<int> insertMemo(MemoData memoData) async {
    Database db = await instance.database;
    return await db.insert(tableName, memoData.toMap());
  }

  Future<List<MemoData>> getMemos() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return MemoData(
        id: maps[i][columnId],
        title: maps[i][columnTitle],
        content: maps[i][columnContent],
      );
    });
  }

  Future<void> deleteMemo(int id) async {
    Database db = await instance.database;
    await db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}

class MemoData {
  final int? id;
  final String title;
  final String content;

  MemoData({
    this.id,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
    };
  }
}
