import 'package:go_router/go_router.dart';
import 'package:aplicacion_taller/screens/sueltas/calander.dart';
import 'package:aplicacion_taller/screens/sueltas/home_screen.dart';
import 'package:aplicacion_taller/screens/sueltas/repair_form.dart';

final sueltasRoutes = [
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
];
