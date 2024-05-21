import 'package:aplicacion_taller/entities/_repair_service.dart';
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
  Set<Service> selectedServices = {};
  double precioTotal = 0.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          const Padding(
            padding: EdgeInsets.all(16.0),
          ),
          ...services.map((service) => CheckboxListTile(
              title: Text(service.nombre),
              value: selectedServices.contains(service),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    selectedServices.add(service);
                    precioTotal += service.precio;
                  } else {
                    selectedServices.remove(service);
                    precioTotal -= service.precio;
                  }
                });
              })),
          const Divider(),
          Text(
            'Precio Total: $precioTotal',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
