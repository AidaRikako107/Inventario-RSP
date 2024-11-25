import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/producto.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('inventario.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE productos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        cantidad INTEGER NOT NULL
      );
    ''');
  }

  Future<int> addProducto(Producto producto) async {
    final db = await instance.database;
    return await db.insert('productos', producto.toMap());
  }

  Future<List<Producto>> getProductos() async {
    final db = await instance.database;
    final result = await db.query('productos');
    return result.map((map) => Producto.fromMap(map)).toList();
  }

  Future<int> updateProducto(Producto producto) async {
    final db = await instance.database;
    return await db.update(
      'productos',
      producto.toMap(),
      where: 'id = ?',
      whereArgs: [producto.id],
    );
  }

  Future<int> deleteProducto(int id) async {
    final db = await instance.database;
    return await db.delete(
      'productos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
