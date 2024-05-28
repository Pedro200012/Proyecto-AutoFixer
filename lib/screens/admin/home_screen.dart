import 'package:flutter/material.dart';
import 'package:aplicacion_taller/widgets/home_screen_base.dart';
import 'package:aplicacion_taller/widgets/navigation_button.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreenBase(
      title: 'Home',
      buttons: [
        NavigationButton(
          text: 'Usuarios',
          route: '/administrador/perfiles',
        ),
        NavigationButton(
          text: 'Turnos',
          route: '/administrador/turnos',
        ),
        NavigationButton(
          text: 'Servicios',
          route: '/administrador/servicios',
        ),
        NavigationButton(
          text: 'Metricas',
          route: '/administrador/metricas',
        ),
      ],
    );
  }
}
