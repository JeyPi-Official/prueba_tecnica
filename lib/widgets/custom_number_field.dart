import 'package:flutter/material.dart';

class CustomNumberField extends StatelessWidget {
  final Widget icon;
  final String text;
  final TextEditingController controller;
  const CustomNumberField({
    super.key,
    required this.icon,
    required this.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(),
      decoration: InputDecoration(
        hintText: text,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: icon,
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo no puede estar vacío';
        }
        if (double.tryParse(value) == null) {
          return 'Debe ser un número válido';
        }
        return null;
      },
    );
  }
}
