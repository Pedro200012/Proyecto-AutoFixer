import 'package:aplicacion_taller/entities/rerparations.dart';
import 'package:aplicacion_taller/screens/sueltas/calander.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplicacion_taller/entities/_repair_service.dart';
import 'package:aplicacion_taller/entities/vehicle.dart';

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
  DateTime? _selectedDate; // Variable para almacenar la fecha seleccionada

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
        padding: const EdgeInsets.all(16.0), // Añado padding general a la vista
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildVehicleSelector(),
            const SizedBox(height: 16),
            _buildServiceList(),
            const SizedBox(height: 16),
            _buildCalendarButton(), // Botón para abrir el calendario
            const SizedBox(height: 16),
            const Divider(),
            _buildTotalPrice(),
            const SizedBox(height: 30),
            _buildReserveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleSelector() {
    return FutureBuilder<List<Vehicle>>(
      future: _vehiclesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            _vehiculosDisponibles = true;
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  title: const Text('Seleccionar vehículo'),
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
                          _vehiculoSeleccionado = value;
                        });
                      },
                      title: Text('${vehicle.brand} ${vehicle.model}'),
                    );
                  }).toList(),
                ),
              ),
            );
          } else {
            _vehiculosDisponibles = false;
            return const Text('No hay vehículos disponibles');
          }
        } else {
          return const Center(
              child:
                  LinearProgressIndicator()); // Muestra un indicador de carga
        }
      },
    );
  }

  Widget _buildServiceList() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          const ListTile(
            title: Text('Seleccionar servicios'),
          ),
          ...services.map((service) {
            return CheckboxListTile(
              title: Text(service.nombre),
              value: _selectedServices.contains(service),
              onChanged: _vehiculosDisponibles && _vehiculoSeleccionado != null
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
                  : null,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCalendarButton() {
    return Container(
      alignment: Alignment.centerLeft,
      child: ElevatedButton(
        onPressed: () async {
          final selectedDate = await Navigator.push<DateTime?>(
            context,
            MaterialPageRoute(
                builder: (context) => RepairRequestCalendar(
                      onDateSelected: handleDateSelected,
                    )),
          );

          if (selectedDate != null) {
            setState(() {
              _selectedDate = selectedDate;
            });
          }
        },
        child: const Text('Seleccionar fecha'),
      ),
    );
  }

  Widget _buildTotalPrice() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        'Precio Total: $_precioTotal',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildReserveButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (_vehiculoSeleccionado != null &&
              _selectedDate != null &&
              _selectedServices.isNotEmpty) {
            _createTurn(); // Llamar a la función para crear el turno
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Por favor seleccione un vehículo, una fecha y al menos un servicio.'),
              ),
            );
          }
        },
        child: const Text('Reservar turno'),
      ),
    );
  }

  Future<List<Vehicle>> _fetchUserVehicles() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('vehiculos')
        .where('userID', isEqualTo: userId)
        .get();
    return snapshot.docs.map((doc) => Vehicle.fromFirestore(doc)).toList();
  }

  void handleDateSelected(DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  Future<void> _createTurn() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    String vehicleId = _vehiculoSeleccionado?.id ?? '';
    List<String> serviceIds = _selectedServices.map((s) => s.id).toList();

    if (userId.isEmpty || vehicleId.isEmpty || serviceIds.isEmpty) {
      return;
    }

    await FirebaseFirestore.instance.collection('turns').add({
      'userId': userId,
      'vehicleId': vehicleId,
      'services': serviceIds,
      'ingreso': _selectedDate,
      'state': 'pendiente',
      'totalPrice': _precioTotal,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Turno reservado con éxito.'),
      ),
    );

    // Opcional: Regresar a la pantalla anterior o a otra pantalla
    Navigator.pop(context);
  }
}
