import 'package:aplicacion_taller/entities/vehicle.dart';
import 'package:flutter/material.dart';

class SeleccionarServicio extends StatelessWidget {
  static const String name = 'seleccionar-servicio-screen';
  const SeleccionarServicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar servicio'),
      ),
      body: const _SerivceSelectionView(),
    );
  }
}

class _SerivceSelectionView extends StatefulWidget {
  const _SerivceSelectionView({
    super.key,
  });

  @override
  State<_SerivceSelectionView> createState() => _SerivceSelectionViewState();
}

class _SerivceSelectionViewState extends State<_SerivceSelectionView> {
  Vehicle vehiculoSeleccionado = vehicles[0];
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ExpansionTile(
          title: const Text('Seleccionar vehiculo'),
          subtitle: Text(
              'vehiculo seleccionado: ${vehiculoSeleccionado.brand}, ${vehiculoSeleccionado.model}'),
          children: vehicles.map((vehicle) {
            return RadioListTile<Vehicle>(
              value: vehicle,
              groupValue: vehiculoSeleccionado,
              onChanged: (Vehicle? value) {
                setState(() {
                  vehiculoSeleccionado = value!;
                });
              },
              title: Text('${vehicle.brand} ${vehicle.model}'),
            );
          }).toList(),
        ),
      ],
    );
  }
}
