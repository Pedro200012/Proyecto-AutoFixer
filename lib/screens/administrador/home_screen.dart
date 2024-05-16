import 'package:flutter/material.dart';

import 'package:aplicacion_taller/screens/administrador/perfiles_screen.dart';
import 'package:aplicacion_taller/screens/administrador/autos_screen.dart';
import 'package:aplicacion_taller/screens/administrador/metricas_screen.dart';
import 'package:aplicacion_taller/screens/administrador/reparaciones_screen.dart';
import 'package:aplicacion_taller/screens/administrador/turnos_screen.dart';

class AdministradorHomeScreen extends StatelessWidget {
  const AdministradorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: true, // This shows the back arrow
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
