import 'package:go_router/go_router.dart';
import 'package:aplicacion_taller/routes/account_routes.dart';
import 'package:aplicacion_taller/routes/admin_routes.dart';
import 'package:aplicacion_taller/routes/cliente_routes.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    ...accountRoutes,
    ...adminRoutes,
    ...clienteRoutes,
  ],
);
