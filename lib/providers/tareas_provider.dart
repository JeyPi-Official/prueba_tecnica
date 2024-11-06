import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/tarea_model.dart';
import '../helpers/db_helper.dart';

class TareasProvider with ChangeNotifier {
  final List<Tarea> _tareas = [];
  final DBHelper _dbHelper = DBHelper();

  List<Tarea> get tareas => _tareas;

  // Carga todas las tareas al instanciar
  TareasProvider() {
    _loadTareasFromDB();
  }

  // Método para cargar las tareas de la base de datos
  Future<void> _loadTareasFromDB() async {
    final tareasFromDB = await _dbHelper.fetchTareas();
    _tareas.addAll(tareasFromDB);
    notifyListeners();
  }

  // Método para guardar una nueva tarea en la base de datos
  Future<void> addTarea(String titulo) async {
    final nuevaTarea = Tarea(
      id: const Uuid().v4(),
      titulo: titulo,
      completada: false,
    );
    _tareas.add(nuevaTarea);
    await _dbHelper.insertTarea(nuevaTarea);
    notifyListeners();
  }

  // Método para modificar el estado de la tarea (completa o no)
  Future<void> toggleTareaStatus(String id) async {
    final tarea = _tareas.firstWhere((t) => t.id == id);
    tarea.completada = !tarea.completada;
    await _dbHelper.updateTarea(tarea);
    notifyListeners();
  }

  // Método para eliminar la tarea de la base de datos
  Future<void> eliminarTarea(String id) async {
    _tareas.removeWhere((t) => t.id == id);
    await _dbHelper.deleteTarea(id);
    notifyListeners();
  }
}
