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

  static Future<Database> _initDB() async{
    String path = join(await getDatabasesPath(), 'lifetrack.db');

    return await openDatabase(
        path,
      version: 1,
      onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE foods (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            caloriePer100g INTEGER
          )
        ''');
          await db.insert('foods', {'name': 'Pasta', 'caloriePer100g': 350});
          await db.insert('foods', {'name': 'Pollo', 'caloriePer100g': 165});
          await db.insert('foods', {'name': 'Mela', 'caloriePer100g': 52});
          await db.insert('foods', {'name': 'Pane', 'caloriePer100g': 265});
          await db.insert('foods', {'name': 'Pizza Margherita', 'caloriePer100g': 270});
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
}