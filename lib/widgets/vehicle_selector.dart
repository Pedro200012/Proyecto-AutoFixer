import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplicacion_taller/entities/vehicle.dart';

class VehicleSelector extends StatefulWidget {
  final ValueChanged<Vehicle?> onVehicleSelected;

  const VehicleSelector({super.key, required this.onVehicleSelected});

  @override
  _VehicleSelectorState createState() => _VehicleSelectorState();
}

class _VehicleSelectorState extends State<VehicleSelector> {
  late Future<List<Vehicle>> _vehiclesFuture;
  Vehicle? _selectedVehicle;

  @override
  void initState() {
    super.initState();
    _vehiclesFuture = _fetchUserVehicles();
  }

  Future<List<Vehicle>> _fetchUserVehicles() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('vehiculos')
        .where('userID', isEqualTo: userId)
        .get();
    return snapshot.docs.map((doc) => Vehicle.fromFirestore(doc)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vehicle>>(
      future: _vehiclesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar los vehículos'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay vehículos disponibles'));
        } else {
          return ExpansionTile(
            title: const Text(
              'Seleccionar vehículo',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            initiallyExpanded: true,
            children: snapshot.data!.map((vehicle) {
              return RadioListTile<Vehicle>(
                title: Text('${vehicle.brand} ${vehicle.model}'),
                value: vehicle,
                groupValue: _selectedVehicle,
                onChanged: (value) {
                  setState(() {
                    _selectedVehicle = value;
                    widget.onVehicleSelected(value);
                  });
                },
              );
            }).toList(),
          );
        }
      },
    );
  }
}
