import 'package:aplicacion_taller/screens/test_screen.dart';
import 'package:aplicacion_taller/screens/repair_form.dart';
import 'package:aplicacion_taller/screens/calander.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TestScreen(),
      ),
      GoRoute(
        path: '/calendar',
        builder: (context, state) => const RepairRequestCalendar(),
      ),
      GoRoute(
        path: '/RepairForm',
        builder: (context, state) => RepairRequestForm(),
      ),
  ]
  
  
  
  
  );