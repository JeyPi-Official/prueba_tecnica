class Tarea {
  final String id;
  final String titulo;
  bool completada;

  Tarea({
    required this.id,
    required this.titulo,
    this.completada = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': titulo,
      'isCompleted': completada ? 1 : 0,
    };
  }
}
