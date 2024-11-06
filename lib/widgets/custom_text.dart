import 'package:flutter/material.dart';

class CustomText extends StatefulWidget {
  final String text;
  const CustomText({super.key, required this.text});

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  late String textoActual;

  @override
  void initState() {
    super.initState();
    textoActual = widget.text;
  }

  void cambiarTexto(String nuevoTexto) {
    setState(() {
      textoActual = nuevoTexto;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 35, color: Colors.purple),
    );
  }
}
