import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:prueba_tecnica/models/photo_model.dart';

class UnsplashProvider extends ChangeNotifier {
  // Keys para acceder a la API de Unsplash
  static const String accessKey = 'cOlgiVLys7b7QSIOMJkZ6N4pCeGaLTLLwd8iJ2ZSP-8';
  static const String baseUrl = 'https://api.unsplash.com/search/photos';

  final List<Photo> photos = [];
  Photo? photoSelected;

  Future<List<Photo>> searchPhotos(String query, int page,
      {int perPage = 10}) async {
    final response = await http.get(
      Uri.parse('$baseUrl?query=$query&per_page=$perPage&client_id=$accessKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Error al realizar la búsqueda');
    }
  }
}
