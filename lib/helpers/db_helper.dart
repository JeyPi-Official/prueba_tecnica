import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/tarea_model.dart';

class DBHelper {
  // Instancia de DBHelper
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  factory DBHelper() => _instance;

  DBHelper._internal();

  // Conección a la base de datos
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // Inicialización de la base de datos (en caso de que no exista)
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'tareas.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE tareas (
            id TEXT PRIMARY KEY,
            title TEXT,
            isCompleted INTEGER
          )
        ''');
      },
      version: 1,
    );
  }

  // Método para insertar una nueva tarea
  Future<void> insertTarea(Tarea tarea) async {
    final db = await database;
    await db.insert('tareas', tarea.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Método para pedir todas las tareas
  Future<List<Tarea>> fetchTareas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tareas');

    return List.generate(maps.length, (i) {
      return Tarea(
        id: maps[i]['id'],
        titulo: maps[i]['title'],
        completada: maps[i]['isCompleted'] == 1,
      );
    });
  }

  // Método para modificar una tarea
  Future<void> updateTarea(Tarea tarea) async {
    final db = await database;
    await db.update(
      'tareas',
      tarea.toMap(),
      where: 'id = ?',
      whereArgs: [tarea.id],
    );
  }

  // Método para borrar una tarea
  Future<void> deleteTarea(String id) async {
    final db = await database;
    await db.delete(
      'tareas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
