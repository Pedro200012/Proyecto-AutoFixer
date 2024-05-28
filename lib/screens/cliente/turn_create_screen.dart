import 'package:flutter/material.dart';
import 'package:aplicacion_taller/entities/vehicle.dart';
import 'package:aplicacion_taller/entities/service.dart';
import 'package:aplicacion_taller/widgets/vehicle_selector.dart';
import 'package:aplicacion_taller/widgets/service_selector.dart';
import 'package:aplicacion_taller/widgets/date_time_selector.dart';

class TurnCreate extends StatefulWidget {
  const TurnCreate({super.key});
  @override
  State<TurnCreate> createState() => _TurnCreateState();
}

class _TurnCreateState extends State<TurnCreate> {
  Vehicle? _selectedVehicle;
  Set<Service> _selectedServices = {};
  DateTime? selectedDate;
  String? selectedHour;

  double getSubtotal() {
    return _selectedServices.fold(
        0.0, (total, service) => total + service.price);
  }

  bool isSubmitEnabled() {
    bool isVehicleSelected = _selectedVehicle != null;
    bool isServiceSelected = _selectedServices.isNotEmpty;
    bool isDateSelected = selectedDate != null;
    bool isHourSelected = selectedHour != null;

    return isVehicleSelected &&
        isServiceSelected &&
        isDateSelected &&
        isHourSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear turno'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            VehicleSelector(
              onVehicleSelected: (vehicle) {
                setState(() {
                  _selectedVehicle = vehicle;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ServiceSelector(
              onServicesSelected: (services) {
                setState(() {
                  _selectedServices = services;
                });
              },
            ),
            const SizedBox(height: 16.0),
            DateTimeSelector(
              onDateSelected: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
              onTimeSelected: (time) {
                setState(() {
                  selectedHour = time;
                });
              },
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Subtotal: \$${getSubtotal().toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: isSubmitEnabled()
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Success'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  : null,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
