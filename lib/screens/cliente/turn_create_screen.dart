import 'package:flutter/material.dart';

import 'package:aplicacion_taller/entities/vehicle.dart';
import 'package:aplicacion_taller/entities/service.dart';
import 'package:aplicacion_taller/widgets/vehicle_selector.dart';
import 'package:aplicacion_taller/widgets/service_selector.dart';

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
            ExpansionTile(
              title: const Text(
                'Select date and time',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              initiallyExpanded: true,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(selectedDate == null
                          ? 'Select date'
                          : 'Selected date: ${selectedDate.toString().substring(0, 10)}'),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1),
                        );
                        if (pickedDate != null && pickedDate != selectedDate) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                    ),
                    ListTile(
                      title: DropdownButtonFormField<String>(
                        value: selectedHour,
                        onChanged: (value) {
                          setState(() {
                            selectedHour = value;
                          });
                        },
                        items: [
                          '9:00 AM',
                          '10:00 AM',
                          '11:00 AM',
                          '12:00 PM',
                          '1:00 PM',
                          '2:00 PM',
                          '3:00 PM',
                          '4:00 PM',
                          '5:00 PM',
                          '6:00 PM',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'Select hour',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
