import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:aplicacion_taller/entities/vehicle.dart';

class VehicleDetailsScreen extends StatelessWidget {
  final Vehicle vehiculo;

  const VehicleDetailsScreen({super.key, required this.vehiculo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Auto'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Modelo: ${vehiculo.model}'),
            Text('Marca: ${vehiculo.brand}'),
            Text('Patente: ${vehiculo.licensePlate}'),
            Text('Año: ${vehiculo.year ?? 'Desconocido'}'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.push('/cliente/vehiculo/edit', extra: vehiculo);
                  },
                  child: const Text('Editar'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Acción de eliminar
                  },
                  child: const Text('Eliminar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
