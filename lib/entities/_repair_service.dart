class Service {
  final String id; // Nuevo campo id
  final String nombre;
  final double precio;
  final String descripcion;
  final Tamanio tamanio;

  Service({
    required this.id, // Agregar id al constructor
    required this.nombre,
    required this.precio,
    required this.descripcion,
    required this.tamanio,
  });
}

enum Tamanio {
  chico,
  grande,
}

List<Service> services = [
  Service(
    id: '1', // ID del servicio 1
    nombre: 'pintra',
    precio: 30000,
    descripcion: 'nueva capa de pintura para todo el vehiculo',
    tamanio: Tamanio.grande,
  ),
  Service(
    id: '2', // ID del servicio 2
    nombre: 'pulido',
    precio: 15000,
    descripcion: 'pulido para todo el vehiculo',
    tamanio: Tamanio.chico,
  ),
];
