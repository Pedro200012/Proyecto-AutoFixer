import 'package:aplicacion_taller/entities/_repair_service.dart';
import 'package:aplicacion_taller/entities/reparations.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class ReparationHistoryScreen extends StatefulWidget {
  static const String name = 'reparation-history-screen';

  const ReparationHistoryScreen({Key? key}) : super(key: key);

  @override
  _ReparationHistoryScreenState createState() =>
      _ReparationHistoryScreenState();
}

class _ReparationHistoryScreenState extends State<ReparationHistoryScreen> {
  late final String userId;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Reparaciones'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('reparaciones')
            .where('userid', isEqualTo: userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Error al cargar las reparaciones'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay reparaciones disponibles'));
          }

          final List<Reparation> reparations = snapshot.data!.docs.map((doc) {
            return Reparation.fromFirestore(doc);
          }).toList();

          return ListView.builder(
            itemCount: reparations.length,
            itemBuilder: (context, index) {
              final reparation = reparations[index];
              return FutureBuilder<Map<String, String>>(
                future: _getVehicleAndUserDetails(
                    reparation.vehicleid, reparation.userid),
                builder: (context, detailsSnapshot) {
                  if (detailsSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const ListTile(title: Text('Cargando...'));
                  } else if (detailsSnapshot.hasError) {
                    return const ListTile(
                        title: Text('Error al cargar detalles'));
                  }

                  final details = detailsSnapshot.data!;
                  return _buildReparationCard(reparation, details);
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<Map<String, String>> _getVehicleAndUserDetails(
      String vehicleId, String userId) async {
    final vehicleDoc = await FirebaseFirestore.instance
        .collection('vehiculos')
        .doc(vehicleId)
        .get();
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return {
      'vehicle': vehicleDoc.exists
          ? vehicleDoc['brand'] + ' ' + vehicleDoc['model']
          : 'Desconocido',
      'user': userDoc.exists ? userDoc['name'] : 'Desconocido',
    };
  }

  Widget _buildReparationCard(
      Reparation reparation, Map<String, String> details) {
    return Card(
      child: ListTile(
        title: Text(
            '${details['vehicle']} (${_getServiceNames(reparation.typeService)})'),
        subtitle:
            Text('Estado: ${reparation.state}\nCliente: ${details['user']}'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          context.push('/cliente/reparation-progress', extra: reparation);
        },
      ),
    );
  }

  String _getServiceNames(List<Service> services) {
    return services.map((service) => service.nombre).join(', ');
  }
}
