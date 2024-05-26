import 'package:aplicacion_taller/screens/cliente/select_service_screen.dart';
import 'package:aplicacion_taller/screens/cliente/vehiculo/details_screen.dart';
import 'package:aplicacion_taller/screens/cliente/vehiculo/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class ClienteHomeScreen extends StatelessWidget {
  const ClienteHomeScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
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
            child: Text('Vehiculos'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SeleccionarServicio(),
                ),
              );
            },
            child: Text('Selecionar servicio'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.push('/sueltas/reparations');
            },
            child: const Text('reparacionesCliente'),
          ),
        ],
      ),
    );
  }
}
