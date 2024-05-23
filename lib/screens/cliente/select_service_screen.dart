import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aplicacion_taller/entities/_repair_service.dart';
import 'package:aplicacion_taller/entities/vehicle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SeleccionarServicio extends StatefulWidget {
  static const String name = 'seleccionar-servicio-screen';
  const SeleccionarServicio({super.key});

  @override
  State<SeleccionarServicio> createState() => _SeleccionarServicioState();
}

class _SeleccionarServicioState extends State<SeleccionarServicio> {
  late Future<List<Vehicle>> _vehiclesFuture;
  Vehicle? _vehiculoSeleccionado;
  final Set<Service> _selectedServices = {};
  double _precioTotal = 0.0;
  bool _vehiculosDisponibles = true;

  @override
  void initState() {
    super.initState();
    _vehiclesFuture = _fetchUserVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar servicio'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder<List<Vehicle>>(
              future: _vehiclesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    _vehiculosDisponibles = true;
                    return ExpansionTile(
                      title: const Text('Seleccionar vehiculo'),
                      subtitle: _vehiculoSeleccionado != null
                          ? Text(
                              'Vehículo seleccionado: ${_vehiculoSeleccionado!.brand}, ${_vehiculoSeleccionado!.model}')
                          : const Text('Seleccione un vehículo'),
                      children: snapshot.data!.map((vehicle) {
                        return RadioListTile<Vehicle>(
                          value: vehicle,
                          groupValue: _vehiculoSeleccionado,
                          onChanged: (value) {
                            setState(() {
                              _vehiculoSeleccionado =
                                  value; // Actualiza el vehículo seleccionado
                            });
                          },
                          title: Text('${vehicle.brand} ${vehicle.model}'),
                        );
                      }).toList(),
                    );
                  } else {
                    _vehiculosDisponibles = false;
                    return const Text('No hay vehículos disponibles');
                  }
                } else {
                  return const SizedBox(); // No muestra nada mientras se está cargando
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
            ),
            ...services.map((service) => CheckboxListTile(
                  title: Text(service.nombre),
                  value: _selectedServices.contains(service),
                  onChanged: _vehiculosDisponibles &&
                          _vehiculoSeleccionado != null
                      ? (bool? value) {
                          setState(() {
                            if (value == true) {
                              _selectedServices.add(service);
                              _precioTotal += service.precio;
                            } else {
                              _selectedServices.remove(service);
                              _precioTotal -= service.precio;
                            }
                          });
                        }
                      : null, // Deshabilita la casilla de verificación si no hay vehículos disponibles o no hay vehículo seleccionado
                )),
            const Divider(),
            Text(
              'Precio Total: $_precioTotal',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    if (_vehiculoSeleccionado != null) {
                      //ir para turnos
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Por favor seleccione o agregue un vehículo antes de solicitar.'),
                        ),
                      );
                    }
                  },
                  child: const Text('Reservar turno')),
            )
          ],
        ),
      ),
    );
  }

  // Método para obtener los vehículos del usuario actual
  Future<List<Vehicle>> _fetchUserVehicles() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('vehiculos')
        .where('userID', isEqualTo: userId)
        .get();
    return snapshot.docs.map((doc) => Vehicle.fromFirestore(doc)).toList();
  }
}
