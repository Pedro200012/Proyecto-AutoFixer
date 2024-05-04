import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenidos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¡Bienvenidos!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/calendar');
              },
              child: const Text('Ir al Calendario'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/RepairForm');
              },
              child: const Text('Ir al Formulario de Reparación'),
            ),
          ],
        ),
      ),
    );
  }
}