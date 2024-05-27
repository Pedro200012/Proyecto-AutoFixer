import 'package:flutter/material.dart';
import 'package:aplicacion_taller/entities/turn.dart';

class VerProgresoReparaciones extends StatelessWidget {
  final Turn turn;

  const VerProgresoReparaciones({Key? key, required this.turn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progreso del Turno'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID del Turno: ${turn.id}',
                style: const TextStyle(fontSize: 18)),
            Text('Estado: ${turn.state}',
                style: const TextStyle(fontSize: 18)),
            Text(
                'Servicios: ${_getServiceNames(turn.services)}',
                style: const TextStyle(fontSize: 18)),
            Text('ID del Vehículo: ${turn.vehicleId}',
                style: const TextStyle(fontSize: 18)),
            Text('ID del Cliente: ${turn.userId}',
                style: const TextStyle(fontSize: 18)),
            // Aquí puedes añadir más información sobre el progreso del turno
          ],
        ),
      ),
    );
  }

  String _getServiceNames(List<String> services) {
    return services.join(', ');
  }
}