import 'package:flutter/material.dart';
import 'package:aplicacion_taller/entities/vehicle.dart';
import 'package:aplicacion_taller/entities/service.dart';
import 'package:aplicacion_taller/widgets/spaced_column.dart';
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

  double _getSubtotal() {
    return _selectedServices.fold(
        0.0, (total, service) => total + service.price);
  }

  bool _isSubmitEnabled() {
    bool isVehicleSelected = _selectedVehicle != null;
    bool isServiceSelected = _selectedServices.isNotEmpty;
    bool isDateSelected = selectedDate != null;
    bool isHourSelected = selectedHour != null;

    return isVehicleSelected &&
        isServiceSelected &&
        isDateSelected &&
        isHourSelected;
  }

  Widget _buildSubtotal() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        'Subtotal: \$${_getSubtotal().toStringAsFixed(2)}',
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _isSubmitEnabled()
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear turno'),
      ),
      body: SpacedColumn(
        children: [
          VehicleSelector(
            onVehicleSelected: (x) => setState(() => _selectedVehicle = x),
          ),
          ServiceSelector(
            onServicesSelected: (x) => setState(() => _selectedServices = x),
          ),
          DateTimeSelector(
            onDateSelected: (x) => setState(() => selectedDate = x),
            onTimeSelected: (x) => setState(() => selectedHour = x),
          ),
          _buildSubtotal(),
          _buildSubmitButton(),
        ],
      ),
    );
  }
}
