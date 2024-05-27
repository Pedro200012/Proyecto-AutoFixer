import 'package:go_router/go_router.dart';
import 'package:aplicacion_taller/screens/admin/home_screen.dart';
import 'package:aplicacion_taller/screens/admin/perfiles/home_screen.dart';
import 'package:aplicacion_taller/screens/admin/perfiles/profile_screen.dart';
import 'package:aplicacion_taller/screens/admin/solicitudAdmin_screen.dart';
import 'package:aplicacion_taller/screens/admin/_autos_screen.dart';
import 'package:aplicacion_taller/screens/admin/_metricas_screen.dart';
import 'package:aplicacion_taller/screens/admin/_reparaciones_screen.dart';
import 'package:aplicacion_taller/screens/admin/_turnos_screen.dart';

import 'package:aplicacion_taller/entities/user.dart';

final adminRoutes = [
  GoRoute(
    path: '/administrador',
    builder: (context, state) => const AdminHomeScreen(),
  ),
  GoRoute(
    path: '/administrador/perfiles',
    builder: (context, state) => const PerfilesScreen(),
  ),
  GoRoute(
    path: '/administrador/perfiles/profile',
    builder: (context, state) => ProfileScreen(user: state.extra as User),
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
  GoRoute(
    path: '/administrador/solicitud',
    builder: (context, state) => const SolicitudAdminScreen(),
  ),
];
