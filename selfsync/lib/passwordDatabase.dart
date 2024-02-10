import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PasswordDatabase {
  static Database? _database;
  static final String tableName = 'passwords';
  static final String columnId = 'id';
  static final String columnAccount = 'account';
  static final String columnMailId = 'mail_id';
  static final String columnPassword = 'password';
  static final String columnUrl = 'url';

  PasswordDatabase._privateConstructor();
  static final PasswordDatabase instance =
      PasswordDatabase._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'passwords_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnAccount TEXT,
            $columnMailId TEXT,
            $columnPassword TEXT,
            $columnUrl TEXT
          )
          ''',
        );
      },
    );
  }

  Future<int> insertPassword(PasswordData passwordData) async {
    Database db = await instance.database;
    return await db.insert(tableName, passwordData.toMap());
  }

  Future<List<PasswordData>> getPasswords() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return PasswordData(
        id: maps[i][columnId],
        account: maps[i][columnAccount],
        mailId: maps[i][columnMailId],
        password: maps[i][columnPassword],
        url: maps[i][columnUrl],
      );
    });
  }

  Future<void> deletePassword(int id) async {
    Database db = await instance.database;
    await db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}

class PasswordData {
  final int? id;
  final String account;
  final String mailId;
  final String password;
  final String url;

  PasswordData({
    this.id,
    required this.account,
    required this.mailId,
    required this.password,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'account': account,
      'mail_id': mailId,
      'password': password,
      'url': url,
    };
  }
}
