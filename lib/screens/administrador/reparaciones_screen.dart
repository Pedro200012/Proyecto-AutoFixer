import 'package:flutter/material.dart';

class ReparacionesScreen extends StatelessWidget {
  const ReparacionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reparaciones'),
        automaticallyImplyLeading: true, // This shows the back arrow
      ),
      body: Center(
        child: Text('Reparaciones Screen'),
      ),
    );
  }
}
