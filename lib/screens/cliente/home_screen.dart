import 'package:flutter/material.dart';
import 'package:aplicacion_taller/widgets/home_screen_base.dart';
import 'package:aplicacion_taller/widgets/navigation_button.dart';

class ClienteHomeScreen extends StatelessWidget {
  const ClienteHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreenBase(
      title: 'Home',
      buttons: [
        NavigationButton(
          text: 'Solicitar turno',
          route: '/cliente/turns/create',
        ),
        NavigationButton(
          text: 'Mis vehiculos',
          route: '/cliente/vehiculo/list',
        ),
        NavigationButton(
          text: 'Mis reparaciones',
          route: '/cliente/reparations',
        ),
        NavigationButton(
          text: 'Solicitar turno (Refactor [WIP])',
          route: '/cliente/turns/create/refactor',
        ),
      ],
    );
  }
}
