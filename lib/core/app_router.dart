import 'package:aplicacion_taller/screens/admin/solicitudAdmin_screen.dart';
import 'package:go_router/go_router.dart';

// entities
import 'package:aplicacion_taller/entities/vehicle.dart';

// account
import 'package:aplicacion_taller/screens/login_screen.dart';
import 'package:aplicacion_taller/screens/register_screen.dart';
// import 'package:aplicacion_taller/screens/restore_password_screen.dart';

// home
import 'package:aplicacion_taller/screens/admin/home_screen.dart';
import 'package:aplicacion_taller/screens/cliente/home_screen.dart';

// admin
import 'package:aplicacion_taller/screens/admin/cliente/list_screen.dart';
import 'package:aplicacion_taller/screens/admin/_autos_screen.dart';
import 'package:aplicacion_taller/screens/admin/_metricas_screen.dart';
import 'package:aplicacion_taller/screens/admin/_reparaciones_screen.dart';
import 'package:aplicacion_taller/screens/admin/_turnos_screen.dart';

// cliente
import 'package:aplicacion_taller/screens/cliente/vehiculo/register_screen.dart';
import 'package:aplicacion_taller/screens/cliente/vehiculo/details_screen.dart';
import 'package:aplicacion_taller/screens/cliente/vehiculo/edit_screen.dart';

// sueltas
import 'package:aplicacion_taller/screens/sueltas/calander.dart';
import 'package:aplicacion_taller/screens/sueltas/home_screen.dart';
import 'package:aplicacion_taller/screens/sueltas/repair_form.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    // account
    GoRoute(
      path: '/login', // login
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    // home
    GoRoute(
      path: '/cliente',
      builder: (context, state) => const ClienteHomeScreen(),
    ),
    GoRoute(
      path: '/administrador',
      builder: (context, state) => const AdministradorHomeScreen(),
    ),

    // admin
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
    GoRoute(
      path: '/', // /administrador/solicitud
      builder: (context, state) => const SolicitudAdminScreen(),
    ),

    // cliente > vehiculo
    GoRoute(
      path: '/cliente/vehiculo/register',
      builder: (context, state) => const VehicleRegisterScreen(),
    ),
    GoRoute(
      path: '/cliente/vehiculo/details',
      builder: (context, state) => VehicleDetailsScreen(
        vehiculo: state.extra as Vehicle,
      ),
    ),
    GoRoute(
      path: '/cliente/vehiculo/edit',
      builder: (context, state) => const VehicleEditScreen(
          //vehiculo: state.extra as Vehicle,
          ),
    ),

    // screens sueltas
    GoRoute(
      path: '/sueltas',
      builder: (context, state) => const SueltasHomeScreen(),
    ),
    GoRoute(
      path: '/sueltas/calendar',
      builder: (context, state) => const RepairRequestCalendar(),
    ),
    GoRoute(
      path: '/sueltas/repair-form',
      builder: (context, state) => RepairRequestFormScreen(),
    ),
  ],
);
