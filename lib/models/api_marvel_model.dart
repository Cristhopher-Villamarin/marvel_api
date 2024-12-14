class Datos {
  final int id;
  final String nombre;
  final String descripcion;
  final String imagen;

  Datos({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.imagen,
  });

  factory Datos.fromJson(Map<String, dynamic> json) {
    return Datos(
      id: json['id'],
      nombre: json['name'],
      descripcion: json['description'] ?? "Descripción no disponible",
      imagen: "${json['thumbnail']['path']}.${json['thumbnail']['extension']}",
    );
  }
}
