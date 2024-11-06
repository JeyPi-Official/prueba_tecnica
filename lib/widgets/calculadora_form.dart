import 'package:flutter/material.dart';
import 'package:prueba_tecnica/services/calculo_propina_service.dart';
import 'package:prueba_tecnica/widgets/custom_gradient_button.dart';
import 'package:prueba_tecnica/widgets/custom_text.dart';
import 'package:prueba_tecnica/widgets/custom_number_field.dart';

final _formKey = GlobalKey<FormState>();

class CalculadoraForm extends StatefulWidget {
  const CalculadoraForm({super.key});

  @override
  State<CalculadoraForm> createState() => _CalculadoraFormState();
}

class _CalculadoraFormState extends State<CalculadoraForm> {
  // Controlador de los campos para gestionar el contenido
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _porcentajeController = TextEditingController();

  //Variables de cálculos
  double _porcentaje = 0;
  double _cantidad = 0;
  double _propina = 0;
  double _total = 0;

  // Textos para hacer display
  String _textoPropina = 'Propina: \$${0.0}';
  String _textoTotal = 'Total: \$${0.0}';

  // Método para resetear el formulario
  void limpiarCampos() {
    _totalController.clear();
    _porcentajeController.clear();
    try {
      _cantidad = double.tryParse(_totalController.text) ?? 0;
      _porcentaje = double.tryParse(_porcentajeController.text) ?? 0;
    } catch (error) {
      print(error); // Manejo de errores en desarrollo
    }
    _propina = 0;
    _total = 0;
    _textoPropina = 'Propina: \$$_propina';
    _textoTotal = 'Total: \$$_total';
  }

  void mostrarSnackbar(BuildContext context, String mensaje) {
    final snackBar = SnackBar(
      content: Text(mensaje),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Método para hacer el calculo de propina y la suma del total
  double calcularPropina() {
    // Validación los datos del campo
    _cantidad = double.tryParse(_totalController.text) ?? 0;
    _porcentaje = double.tryParse(_porcentajeController.text) ?? 0;
    if (_cantidad != 0 && _porcentaje != 0) {
      _propina =
          CalculoPropinaService().calcularPropina(_cantidad, _porcentaje);
      _total = calcularTotal();
      cambiarTexto('Propina: \$$_propina', 'Total: \$$_total');
      return _propina;
    }
    mostrarSnackbar(context, 'Ingresa una cantidad válida!');
    return 0;
  }

  double calcularTotal() {
    return _cantidad + _propina;
  }

  // Método para modificar el texto sin usar provider
  void cambiarTexto(String nuevoTextoPropina, String nuevoTextoTotal) {
    setState(() {
      _textoPropina = nuevoTextoPropina;
      _textoTotal = nuevoTextoTotal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomNumberField(
                controller: _totalController,
                icon: const Icon(Icons.attach_money_outlined),
                text: 'Cantidad Total',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomNumberField(
                controller: _porcentajeController,
                icon: const Icon(Icons.percent_outlined),
                text: 'Porcentaje',
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomGradientButton(
                  colors: const [Colors.lightGreen, Colors.green],
                  text: 'Calcular',
                  onPressed: () => {
                    _propina = calcularPropina(),
                    cambiarTexto(_textoPropina, _textoTotal),
                  },
                ),
                CustomGradientButton(
                  colors: const [Colors.pink, Colors.purple],
                  text: 'Limpiar',
                  onPressed: () => {
                    limpiarCampos(),
                    cambiarTexto(_textoPropina, _textoTotal),
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: CustomText(
                text: _textoPropina,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomText(
                text: _textoTotal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
