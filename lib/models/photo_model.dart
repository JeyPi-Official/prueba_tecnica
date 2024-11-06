import 'dart:convert';

class Photo {
  Photo({
    required this.titulo,
    required this.imageUrl,
    this.id,
  });

  String titulo;
  String imageUrl;
  String? id;

  factory Photo.fromJson(String str) => Photo.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());
  factory Photo.fromMap(Map<String, dynamic> json) => Photo(
        titulo: json["alt_description"] ?? 'Sin título',
        imageUrl: json["urls"]["regular"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "título": titulo,
        "imageUrl": imageUrl,
        "id": id,
      };

  Photo copy() => Photo(
      titulo: titulo,
      imageUrl: imageUrl,
      id: id); // Para hacer una copia en una Page vacía
}
