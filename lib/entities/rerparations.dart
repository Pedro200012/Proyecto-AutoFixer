import 'package:aplicacion_taller/entities/_repair_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Reparation {
  final String? id;
  final String userid;
  final String vehicleid;
  final String state;
  final List<Service> typeService;
  final DateTime fechaIngreso;
  final DateTime? fechaSalida;
  final double? precioTotal;

  Reparation({
    this.id,
    required this.userid,
    required this.typeService,
    required this.vehicleid,
    required this.state,
    required this.fechaIngreso,
    this.fechaSalida,
    this.precioTotal
  });

  factory Reparation.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Reparation(
      id: doc.id,
      userid: data['userid'] ?? '',
      typeService:
          (data['typeService'] as List<dynamic> ?? []).map((serviceData) {
        return Service.fromMap(serviceData as Map<String, dynamic>);
      }).toList(),
      vehicleid: data['vehicleid'] ?? '',
      state: data['state'] ?? '',
      fechaIngreso: data['fechaIngreso'] ?? '',
      fechaSalida: data['fechaSalida'] ?? '',
      precioTotal: data['precioTotal'] ?? ''
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userid': userid,
      'typeService': typeService.map((service) => service.toMap()).toList(),
      'vehicleid': vehicleid,
      'state': state,
      'fechaIngreso': fechaIngreso,
      'fechaSalida': fechaSalida,
      'precioTotal': precioTotal
    };
  }
}
