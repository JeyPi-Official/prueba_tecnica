import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/pages/photo_page.dart';
import 'package:prueba_tecnica/providers/tareas_provider.dart';
import 'package:prueba_tecnica/pages/home_page.dart';
import 'package:prueba_tecnica/services/unsplash_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TareasProvider(), // Provider del estado de tareas
        ),
        ChangeNotifierProvider(
          create: (_) => UnsplashProvider(), //Provider para la API
        )
      ],
      child: MaterialApp(
        routes: {
          'photo': (context) => const PhotoPage(),
        },
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
