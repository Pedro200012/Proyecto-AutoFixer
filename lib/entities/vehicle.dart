import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  final String model;
  final String brand;
  final String licensePlate;
  final int? year;

  Vehicle({
    required this.model,
    required this.brand,
    required this.licensePlate,
    this.year,
  });

  factory Vehicle.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Vehicle(
      model: data['model'] ?? '',
      brand: data['brand'] ?? '',
      licensePlate: data['licensePlate'] ?? '',
      year: data['year'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'model': model,
      'brand': brand,
      'licensePlate': licensePlate,
      'year': year,
    };
  }
}

List<Vehicle> vehicles = [
  Vehicle(model: 'Sedan', brand: 'Toyota', licensePlate: 'ABC123', year: 2015),
  Vehicle(model: 'Adventure', brand: 'Fiat', licensePlate: 'HJF123', year: 2010),
];
