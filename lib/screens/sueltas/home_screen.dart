import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SueltasHomeScreen extends StatelessWidget {
  const SueltasHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screens sueltas'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ElevatedButton(
            //   onPressed: () {
            //     context.push('/sueltas/calendar');
            //   },
            //   child: const Text('Ir al Calendario'),
            // ),
            // const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     context.push('/sueltas/repair-form');
            //   },
            //   child: const Text('Ir al Formulario de Reparación'),
            // ),
          ],
        ),
      ),
    );
  }
}
