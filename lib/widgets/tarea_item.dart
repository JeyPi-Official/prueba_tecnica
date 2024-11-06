import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/providers/tareas_provider.dart';
import 'package:prueba_tecnica/models/tarea_model.dart';

class TareaItem extends StatelessWidget {
  final Tarea tarea;

  const TareaItem({super.key, required this.tarea});

  @override
  Widget build(BuildContext context) {
    // Para gestionar el estado de la tarea
    final tareaProvider = Provider.of<TareasProvider>(context, listen: false);

    return ListTile(
      title: Text(
        tarea.titulo,
        style: TextStyle(
          decoration: tarea.completada
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      leading: Checkbox(
        side: const BorderSide(
          color: Colors.purple,
          width: 2,
        ),
        activeColor: Colors.pink,
        value: tarea.completada,
        onChanged: (_) {
          tareaProvider.toggleTareaStatus(tarea.id);
        },
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.blue,
        ),
        onPressed: () {
          tareaProvider.eliminarTarea(tarea.id);
        },
      ),
    );
  }
}
