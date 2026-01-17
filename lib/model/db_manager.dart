import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'food.dart';

class DbManager {
  static Database? _database;

  static Future<Database> get database async{
    if(_database != null) return _database!;
    _database=await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'lifetrack.db');

    return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          //TABELLA CIBI
          await db.execute('''
          CREATE TABLE foods (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            caloriePer100g INTEGER
          )
        ''');
          //TABELLA PROFILO UTENTE
          await db.execute('''
            CREATE TABLE user_profile (
            id INTEGER PRIMARY KEY,
            weight REAL,
            height REAL,
            age INTEGER,
            gender TEXT,
            goal TEXT,
            dailyCalories INTEGER,
            consumedCalories INTEGER,
            lastUpdate TEXT
          )
      ''');
          //inserimento dei cibi
          await db.insert('foods', {'name': 'Pasta', 'caloriePer100g': 350});
          await db.insert('foods', {'name': 'Pollo', 'caloriePer100g': 165});
          await db.insert('foods', {'name': 'Mela', 'caloriePer100g': 52});
          await db.insert('foods', {'name': 'Pane', 'caloriePer100g': 265});
          await db.insert('foods', {'name': 'Pizza Margherita', 'caloriePer100g': 270});

          //inserimento utente
          await db.insert('user_profile', {
            'id': 1,
            'weight': 0,
            'height': 0,
            'age': 17,
            'gender': 'M',
            'goal': 'maintain',
            'dailyCalories': 2000,
            'consumedCalories': 0,
            'lastUpdate': DateTime.now().toIso8601String().split('T')[0] //salvo la data di oggi
          });
        }
    );
  }
  static Future<List<Food>> searchFoods(String query) async{
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'foods',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );
    return List.generate(maps.length, (i) {
      return Food.fromMap(maps[i]);
    });
  }

  // Carica i dati dell'utente dal DB
  static Future<Map<String, dynamic>> getUserProfile() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('user_profile', where: 'id = ?', whereArgs: [1]);
    return maps.first;
  }

  // Aggiorna i dati dell'utente
  static Future<void> updateUserProfile(Map<String, dynamic> data) async {
    final db = await database;
    await db.update(
      'user_profile',
      data,
      where: 'id = ?',
      whereArgs: [1],
    );
  }
}