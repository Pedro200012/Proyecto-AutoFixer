import 'package:flutter/material.dart';
import 'package:aplicacion_taller/widgets/home_screen_base.dart';
import 'package:aplicacion_taller/widgets/navigation_button.dart';
import 'package:go_router/go_router.dart';

class ClienteHomeScreen extends StatelessWidget {
  const ClienteHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home: Cliente'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, size: 30.0), // Tamaño del icono ajustado
            onPressed: () {
              context.push('/cliente/editar/perfil/');
              // Acción del botón de usuario
            },
            iconSize: 30.0, // Tamaño del icono ajustado
          ),
        ],
      ),
      body: const HomeScreenBase(
        title: 'Funcionalidades de la app',
        buttons: [
          NavigationButton(
            text: 'Solicitar turno',
            route: '/cliente/turns/create',
            icon: Icon(Icons.calendar_month),
          ),
          NavigationButton(
            text: 'Mis vehiculos',
            route: '/cliente/vehiculo/list',
            icon: Icon(Icons.car_rental),
          ),
          NavigationButton(
            text: 'Mis reparaciones',
            route: '/cliente/reparations',
            icon: Icon(Icons.build),
          ),
          NavigationButton(
            text: 'Solicitar turno (2)',
            route: '/cliente/turns/create/refactor',
            icon: Icon(Icons.calendar_month),
          ),
        ],
      ),
    );
  }
}