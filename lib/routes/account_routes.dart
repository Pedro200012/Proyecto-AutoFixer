import 'package:go_router/go_router.dart';
import 'package:aplicacion_taller/screens/login_screen.dart';
import 'package:aplicacion_taller/screens/register_screen.dart';

final accountRoutes = [
  GoRoute(
    path: '/',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/register',
    builder: (context, state) => const RegisterScreen(),
  ),
];
