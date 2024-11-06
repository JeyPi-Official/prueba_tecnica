import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/providers/tareas_provider.dart';
import 'package:prueba_tecnica/widgets/custom_gradient_button.dart';
import '../widgets/tarea_item.dart';

class TareasPage extends StatelessWidget {
  // Uso de controller para manejar la información del TextField
  final TextEditingController _controller = TextEditingController();

  TareasPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Uso del provider para la gestión de la lista de tareas
    final tareasProvider = Provider.of<TareasProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'Lista de Tareas',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Tarea',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Icon(Icons.list_outlined),
                  ),
                  suffixIcon: CustomGradientButton(
                    colors: const [Colors.pink, Colors.purple],
                    text: 'Agregar',
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        tareasProvider.addTarea(_controller.text);
                        _controller.clear();
                      }
                    },
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.purple),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            // Uso de Expanded para el efecto Slide de la lista
            Expanded(
              // Uso de consumer para mostrar las tareas parcialmente
              child: Consumer<TareasProvider>(
                builder: (context, tareasProvider, _) => ListView.builder(
                  itemCount: tareasProvider.tareas.length,
                  itemBuilder: (context, index) {
                    final tarea = tareasProvider.tareas[index];
                    return TareaItem(tarea: tarea);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
