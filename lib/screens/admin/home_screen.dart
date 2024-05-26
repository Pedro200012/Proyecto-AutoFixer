import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import 'package:aplicacion_taller/screens/admin/perfiles/home_screen.dart';
import 'package:aplicacion_taller/screens/admin/_autos_screen.dart';
import 'package:aplicacion_taller/screens/admin/_metricas_screen.dart';
import 'package:aplicacion_taller/screens/admin/_reparaciones_screen.dart';
import 'package:aplicacion_taller/screens/admin/_turnos_screen.dart';

class AdministradorHomeScreen extends StatelessWidget {
  const AdministradorHomeScreen({super.key});

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
                  builder: (context) => const PerfilesScreen(),
                ),
              );
            },
            child: Text('Perfiles'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TurnosScreen(),
                ),
              );
            },
            child: Text('Turnos'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReparacionesScreen(),
                ),
              );
            },
            child: Text('Reparaciones'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AutosScreen(),
                ),
              );
            },
            child: Text('Autos'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MetricasScreen(),
                ),
              );
            },
            child: Text('Metricas'),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
