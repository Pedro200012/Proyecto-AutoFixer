import 'package:flutter/material.dart';

class ServiciosScreen extends StatelessWidget {
  const ServiciosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicios'),
        automaticallyImplyLeading: true, // This shows the back arrow
      ),
      body: const Center(
        child: Text('Servicios Screen'),
      ),
    );
  }
}
