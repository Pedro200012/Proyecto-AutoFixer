import 'package:go_router/go_router.dart';

import 'package:aplicacion_taller/screens/login_screen.dart';
import 'package:aplicacion_taller/screens/administrador/home_screen.dart';
import 'package:aplicacion_taller/screens/administrador/perfiles_screen.dart';
import 'package:aplicacion_taller/screens/administrador/autos_screen.dart';
import 'package:aplicacion_taller/screens/administrador/metricas_screen.dart';
import 'package:aplicacion_taller/screens/administrador/reparaciones_screen.dart';
import 'package:aplicacion_taller/screens/administrador/turnos_screen.dart';
import 'package:aplicacion_taller/screens/cliente/home_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/cliente',
      builder: (context, state) => const ClienteHomeScreen(),
    ),
    // Administrador
    GoRoute(
      path: '/administrador',
      builder: (context, state) => const AdministradorHomeScreen(),
    ),
    GoRoute(
      path: '/administrador/perfiles',
      builder: (context, state) => const PerfilesScreen(),
    ),
    GoRoute(
      path: '/administrador/turnos',
      builder: (context, state) => const TurnosScreen(),
    ),
    GoRoute(
      path: '/administrador/reparaciones',
      builder: (context, state) => const ReparacionesScreen(),
    ),
    GoRoute(
      path: '/administrador/autos',
      builder: (context, state) => const AutosScreen(),
    ),
    GoRoute(
      path: '/administrador/metricas',
      builder: (context, state) => const MetricasScreen(),
    ),
  ],
);
