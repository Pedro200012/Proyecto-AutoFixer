import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:aplicacion_taller/screens/login_screen.dart';
import 'package:aplicacion_taller/screens/administrador/home_screen.dart';
import 'package:aplicacion_taller/screens/cliente/home_screen.dart';
import 'package:aplicacion_taller/screens/administrador/perfiles_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/administrador',
      builder: (context, state) => const AdministradorHomeScreen(),
    ),
    GoRoute(
      path: '/cliente',
      builder: (context, state) => const ClienteHomeScreen(),
    ),
    GoRoute(
      path: '/administrador/perfiles',
      builder: (context, state) => const PerfilesScreen(),
    ),
  ],
);
