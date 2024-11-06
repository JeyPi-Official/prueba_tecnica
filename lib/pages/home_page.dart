import 'package:flutter/material.dart';
import 'package:prueba_tecnica/widgets/custom_navbar.dart';
import 'package:prueba_tecnica/pages/api_page.dart';
import 'package:prueba_tecnica/pages/calculadora_page.dart';
import 'package:prueba_tecnica/pages/tareas_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  //Lista de págins para navegar
  final List<Widget> _pages = [
    const CalculadoraPage(),
    TareasPage(),
    const ApiPage(),
  ];

  //Método para navegar con la barra
  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: _onTabChange,
      ),
    );
  }
}
