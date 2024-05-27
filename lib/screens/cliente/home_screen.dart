import 'package:aplicacion_taller/screens/cliente/select_service_screen.dart';
import 'package:aplicacion_taller/screens/cliente/vehiculo/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class ClienteHomeScreen extends StatelessWidget {
  const ClienteHomeScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VehicleListScreen(),
                ),
              );
            },
            child: const Text('Vehiculos'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SeleccionarServicio(),
                ),
              );
            },
            child: const Text('Selecionar servicio'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.push('/cliente/reparations');
            },
            child: const Text('reparacionesCliente'),
          ),
        ],
      ),
    );
  }
}
