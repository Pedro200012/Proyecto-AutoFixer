import 'package:flutter/material.dart';
import 'package:aplicacion_taller/widgets/home_screen_base.dart';
import 'package:aplicacion_taller/widgets/navigation_button.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreenBase(
      title: 'Home: Admin',
      buttons: [
        NavigationButton(
          text: 'Metricas',
          route: '/administrador/metricas',
          icon: Icon(Icons.bar_chart),
        ),
        NavigationButton(
          text: 'Turnos',
          route: '/administrador/turnos',
          icon: Icon(Icons.calendar_month),
        ),
        NavigationButton(
          text: 'Usuarios',
          route: '/administrador/perfiles',
          icon: Icon(Icons.person),
        ),
        NavigationButton(
          text: 'Servicios',
          route: '/administrador/servicios',
          icon: Icon(Icons.local_hospital),
        ),
      ],
    );
  }
}
