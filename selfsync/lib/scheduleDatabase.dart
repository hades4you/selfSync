import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ScheduleDatabase {
  static Database? _database;
  static final String tableName = 'events';
  static final String columnId = 'id';
  static final String columnTitle = 'title';
  static final String columnDateTime = 'date_time';
  static final String columnContext = 'context';

  ScheduleDatabase._privateConstructor();
  static final ScheduleDatabase instance =
      ScheduleDatabase._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'events_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTitle TEXT,
            $columnDateTime TEXT,
            $columnContext TEXT
          )
          ''',
        );
      },
    );
  }

  Future<int> insertEvent(Event event) async {
    Database db = await instance.database;
    return await db.insert(tableName, event.toMap());
  }

  Future<List<Event>> getEvents() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Event(
        id: maps[i][columnId],
        title: maps[i][columnTitle],
        dateTime: maps[i][columnDateTime],
        context: maps[i][columnContext],
      );
    });
  }

  Future<void> deleteEvent(int eventId) async {
    Database db = await instance.database;
    await db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [eventId],
    );
  }
}

class Event {
  final int? id;
  final String title;
  final String dateTime;
  final String context;

  Event(
      {this.id,
      required this.title,
      required this.dateTime,
      required this.context});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date_time': dateTime,
      'context': context,
    };
  }
}
