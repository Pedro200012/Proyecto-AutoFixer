import 'package:flutter/material.dart';

class SolicitudAdminScreen extends StatelessWidget {
  const SolicitudAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitud confirmacion'),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Column(

          children: [
            Text("este es el formulario"),
            Text("")
          ],
        ),
      ),
    );
  }
}