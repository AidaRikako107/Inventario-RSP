class Producto {
  int? id;
  String nombre;
  int cantidad;

  Producto({this.id, required this.nombre, required this.cantidad});

  // Convertir el Producto a un mapa para insertarlo en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'cantidad': cantidad,
    };
  }

  // Crear un Producto a partir de un mapa (para leer de la base de datos)
  factory Producto.fromMap(Map<String, dynamic> map) {
    return Producto(
      id: map['id'],
      nombre: map['nombre'],
      cantidad: map['cantidad'],
    );
  }
}

