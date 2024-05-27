import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'
    as firebase_auth; // Alias para FirebaseAuth
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:aplicacion_taller/entities/turn.dart';

class ReparationHistoryScreen extends StatelessWidget {
  static const String name = 'reparation-history-screen';

  const ReparationHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Reparaciones'),
      ),
      body: StreamBuilder<firebase_auth.User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, authSnapshot) {
          if (authSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!authSnapshot.hasData) {
            return const Center(child: Text('No has iniciado sesión'));
          }

          final String userId = authSnapshot.data!.uid;

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('turns')
                .where('userId', isEqualTo: userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error al cargar los turnos'));
              }

              final data = snapshot.requireData;
              List<Turn> turns =
                  data.docs.map((doc) => Turn.fromFirestore(doc)).toList();

              if (turns.isEmpty) {
                return const Center(child: Text('No hay turnos disponibles'));
              }

              return _ListTurnView(turns: turns);
            },
          );
        },
      ),
    );
  }
}

class _ListTurnView extends StatelessWidget {
  final List<Turn> turns;

  const _ListTurnView({required this.turns});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: turns.length,
      itemBuilder: (context, index) {
        final turn = turns[index];
        return _TurnItem(turn: turn);
      },
    );
  }
}

class _TurnItem extends StatelessWidget {
  final Turn turn;

  const _TurnItem({required this.turn});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(turn.ingreso);

    return FutureBuilder<Map<String, dynamic>>(
      future: _getUserDetails(turn.userId),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        }
        if (userSnapshot.hasError) {
          return const Text('Error al cargar detalles del usuario');
        }
        if (!userSnapshot.hasData) {
          return const Text('Detalles del usuario no encontrados');
        }

        final userData = userSnapshot.data!;
        final String userName =
            userData['name'] ?? 'Desconocido'; // Nombre del usuario

        return FutureBuilder<Map<String, dynamic>>(
          future: _getVehicleDetails(turn.vehicleId),
          builder: (context, vehicleSnapshot) {
            if (vehicleSnapshot.connectionState == ConnectionState.waiting) {
              return const LinearProgressIndicator();
            }
            if (vehicleSnapshot.hasError) {
              return const Text('Error al cargar detalles del vehículo');
            }
            if (!vehicleSnapshot.hasData) {
              return const Text('Detalles del vehículo no encontrados');
            }

            final vehicleData = vehicleSnapshot.data!;
            final String vehicleBrand = vehicleData['brand'] ?? 'Desconocido';
            final String vehicleModel = vehicleData['model'] ?? 'Desconocido';

            return Card(
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cliente: $userName'), // Mostrar el nombre del cliente
                    Text('Marca del vehículo: $vehicleBrand'),
                    Text('Modelo del vehículo: $vehicleModel'),
                    Text('Fecha de ingreso: $formattedDate'),
                    Text('Estado del turno: ${turn.state}'),
                  ],
                ),
                onTap: () {
                  // context.push('/cliente/reparation-progress');
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<Map<String, dynamic>> _getUserDetails(String userId) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return userDoc.data() as Map<String, dynamic>? ?? {};
  }

  Future<Map<String, dynamic>> _getVehicleDetails(String vehicleId) async {
    final vehicleDoc = await FirebaseFirestore.instance
        .collection('vehiculos')
        .doc(vehicleId)
        .get();
    return vehicleDoc.data() as Map<String, dynamic>? ?? {};
  }
}