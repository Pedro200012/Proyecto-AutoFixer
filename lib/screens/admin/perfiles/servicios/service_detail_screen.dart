import 'dart:developer';

import 'package:flutter/material.dart';

class ServicieDetailScreen extends StatelessWidget {
  final Service service;

  const ServicieDetailScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       service.name,
        //       style: TextStyle(
        //         fontSize: 24.0,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //     SizedBox(height: 20.0),
        //     Text(
        //       service.description,
        //       style: TextStyle(fontSize: 18.0),
        //     ),
        //     // Aquí puedes agregar más detalles o funcionalidades de edición
        //   ],
        // ),
      ),
    );
  }
}