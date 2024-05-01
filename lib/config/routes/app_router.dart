import 'package:aplicacion_taller/screens/test_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TestScreen(),
      )
  ]
  
  
  
  
  );