import 'package:aplicacion_taller/entities/_repair_service.dart';
import 'package:aplicacion_taller/entities/rerparations.dart';
import 'package:flutter/material.dart';

class VerProgresoReparaciones extends StatelessWidget {
  final Reparation reparation;

  const VerProgresoReparaciones({Key? key, required this.reparation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progreso de la Reparación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID de Reparación: ${reparation.id}',
                style: const TextStyle(fontSize: 18)),
            Text('Estado: ${reparation.state}',
                style: const TextStyle(fontSize: 18)),
            Text(
                'Tipo de Servicio: ${_getServiceNames(reparation.typeService)}',
                style: const TextStyle(fontSize: 18)),
            Text('ID del Vehículo: ${reparation.vehicleid}',
                style: const TextStyle(fontSize: 18)),
            Text('ID del Cliente: ${reparation.userid}',
                style: const TextStyle(fontSize: 18)),
            // Aquí puedes añadir más información sobre el progreso de la reparación
          ],
        ),
      ),
    );
  }

  String _getServiceNames(List<Service> services) {
    return services.map((service) => service.nombre).join(', ');
  }
}
