import 'package:flutter/material.dart';
import 'package:prueba_tecnica/pages/photos_page.dart';

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: PhotosPage()),
    );
  }
}
