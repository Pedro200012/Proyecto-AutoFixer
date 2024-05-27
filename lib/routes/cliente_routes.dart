import 'package:go_router/go_router.dart';

import 'package:aplicacion_taller/screens/cliente/home_screen.dart';
import 'package:aplicacion_taller/screens/cliente/select_service_screen.dart';
import 'package:aplicacion_taller/screens/cliente/progress_reparation.dart';
import 'package:aplicacion_taller/screens/cliente/reparaciones_screen.dart';
import 'package:aplicacion_taller/screens/cliente/vehiculo/list_screen.dart';
import 'package:aplicacion_taller/screens/cliente/vehiculo/register_screen.dart';
import 'package:aplicacion_taller/screens/cliente/vehiculo/details_screen.dart';
import 'package:aplicacion_taller/screens/cliente/vehiculo/edit_screen.dart';

import 'package:aplicacion_taller/entities/vehicle.dart';
import 'package:aplicacion_taller/entities/rerparations.dart';

final clienteRoutes = [
  GoRoute(
    path: '/cliente',
    builder: (context, state) => const ClienteHomeScreen(),
  ),
  GoRoute(
    path: '/cliente/reparations',
    builder: (context, state) => const ReparationHistoryScreen(),
  ),
  GoRoute(
    path: '/sueltas/reparation-progress',
    builder: (context, state) =>
        VerProgresoReparaciones(reparation: state.extra as Reparation),
  ),
  GoRoute(
    path: '/cliente/turns/create',
    builder: (context, state) => const SeleccionarServicio(),
  ),
  GoRoute(
    path: '/cliente/vehiculo/list',
    builder: (context, state) => const VehicleListScreen(),
  ),
  GoRoute(
    path: '/cliente/vehiculo/register',
    builder: (context, state) => const VehicleRegisterScreen(),
  ),
  GoRoute(
    path: '/cliente/vehiculo/details',
    builder: (context, state) =>
        VehicleDetailsScreen(vehiculo: state.extra as Vehicle),
  ),
  GoRoute(
    path: '/cliente/vehiculo/edit',
    builder: (context, state) =>
        VehicleEditScreen(vehicle: state.extra as Vehicle),
  ),
];
