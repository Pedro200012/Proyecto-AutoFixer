// ignore_for_file: constant_identifier_names

class Service {
  final String nombre;
  final double precio;
  final String descripcion;
  final Tamanio tamanio;

  Service({
    required this.nombre,
    required this.precio,
    required this.descripcion,
    required this.tamanio,
  });

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      nombre: map['nombre'] ?? '',
      precio: map['precio'] ?? 0.0,
      descripcion: map['descripcion'] ?? '',
      tamanio: Tamanio.values[map['tamanio'] ?? 0],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'precio': precio,
      'descripcion': descripcion,
      'tamanio': tamanio.index,
    };
  }

}

enum Tamanio {
  CHICO,
  GRANDE,
}

List<Service> services = [
  Service(
      nombre: 'pintra',
      precio: 30000,
      descripcion: 'nueva capa de pintura para todo el vehiculo',
      tamanio: Tamanio.GRANDE),
  Service(
      nombre: 'pulido',
      precio: 15000,
      descripcion: 'pulido para todo el vehiculo',
      tamanio: Tamanio.CHICO),
];
