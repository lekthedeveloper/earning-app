import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'wallet.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE wallet (id INTEGER PRIMARY KEY, totalEarning REAL, spins INTEGER, spinDate TEXT, weekDayisTap INTEGER, checkInDate TEXT)',
    );
    await db.insert('wallet', {
      'id': 1,
      'totalEarning': 0.0,
      'spins': 0,
      'spinDate': '',
      'weekDayisTap': 0,
      'checkInDate': ''
    });
  }

  Future<double> getTotalEarnings() async {
    Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query('wallet', where: 'id = ?', whereArgs: [1]);
    return results.isNotEmpty ? results.first['totalEarning'] as double : 0.0;
  }

  Future<int> getSpinCount() async {
    Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query('wallet', where: 'id = ?', whereArgs: [1]);
    return results.isNotEmpty ? results.first['spins'] as int : 0;
  }

  Future<String> getSpinDate() async {
    Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query('wallet', where: 'id = ?', whereArgs: [1]);
    return results.isNotEmpty ? results.first['spinDate'] as String : '';
  }

  Future<bool> getWeekDayisTap() async {
    Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query('wallet', where: 'id = ?', whereArgs: [1]);
    return results.isNotEmpty ? results.first['weekDayisTap'] == 1 : false;
  }

  Future<String> getCheckInDate() async {
    Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query('wallet', where: 'id = ?', whereArgs: [1]);
    return results.isNotEmpty ? results.first['checkInDate'] as String : '';
  }

  Future<void> updateTotalEarnings(double totalEarning) async {
    Database db = await database;
    await db.update('wallet', {'totalEarning': totalEarning},
        where: 'id = ?', whereArgs: [1]);
  }

  Future<void> updateSpinData(int spins, String spinDate) async {
    Database db = await database;
    await db.update('wallet', {'spins': spins, 'spinDate': spinDate},
        where: 'id = ?', whereArgs: [1]);
  }

  Future<void> updateWeekDayisTap(bool weekDayisTap, String checkInDate) async {
    Database db = await database;
    await db.update('wallet',
        {'weekDayisTap': weekDayisTap ? 1 : 0, 'checkInDate': checkInDate},
        where: 'id = ?', whereArgs: [1]);
  }
}
