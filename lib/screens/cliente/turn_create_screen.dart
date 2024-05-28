import 'package:flutter/material.dart';
import 'package:aplicacion_taller/entities/vehicle.dart';
import 'package:aplicacion_taller/entities/service.dart';
import 'package:aplicacion_taller/widgets/spaced_column.dart';
import 'package:aplicacion_taller/widgets/vehicle_selector.dart';
import 'package:aplicacion_taller/widgets/service_selector.dart';
import 'package:aplicacion_taller/widgets/date_time_selector.dart';
import 'package:aplicacion_taller/widgets/loading_screen.dart';
import 'package:aplicacion_taller/widgets/error_screen.dart';

class TurnCreate extends StatefulWidget {
  const TurnCreate({super.key});
  @override
  State<TurnCreate> createState() => _TurnCreateState();
}

class _TurnCreateState extends State<TurnCreate> {
  Vehicle? _selectedVehicle;
  Set<Service> _selectedServices = {};
  DateTime? _selectedDate;
  String? _selectedHour;

  late Future<void> _initialLoadFuture;
  List<Vehicle>? _vehicles;
  List<Service>? _services;

  @override
  void initState() {
    super.initState();
    _initialLoadFuture = _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final vehiclesFuture = VehicleSelector.loadVehicles();
    final servicesFuture = ServiceSelector.loadServices();
    final results = await Future.wait([vehiclesFuture, servicesFuture]);

    _vehicles = results[0] as List<Vehicle>;
    _services = results[1] as List<Service>;
  }

  double _getSubtotal() {
    return _selectedServices.fold(
        0.0, (total, service) => total + service.price);
  }

  bool _isSubmitEnabled() {
    bool isVehicleSelected = _selectedVehicle != null;
    bool isServiceSelected = _selectedServices.isNotEmpty;
    bool isDateSelected = _selectedDate != null;
    bool isHourSelected = _selectedHour != null;

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

  Widget _buildMainContent() {
    return SpacedColumn(
      children: [
        VehicleSelector(
          vehicles: _vehicles!,
          onVehicleSelected: (x) => setState(() => _selectedVehicle = x),
        ),
        ServiceSelector(
          services: _services!,
          onServicesSelected: (x) => setState(() => _selectedServices = x),
        ),
        DateTimeSelector(
          onDateSelected: (x) => setState(() => _selectedDate = x),
          onTimeSelected: (x) => setState(() => _selectedHour = x),
        ),
        _buildSubtotal(),
        _buildSubmitButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: const Text('Crear turno'));

    return FutureBuilder<void>(
      future: _initialLoadFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen(appBar: appBar);
        }
        if (snapshot.hasError) {
          return ErrorScreen(
            appBar: appBar,
            errorMessage: 'Error al cargar los datos',
          );
        }
        return Scaffold(
          appBar: appBar,
          body: _buildMainContent(),
        );
      },
    );
  }
}
