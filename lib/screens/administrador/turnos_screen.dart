import 'package:flutter/material.dart';

class TurnosScreen extends StatelessWidget {
  const TurnosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Turnos'),
        automaticallyImplyLeading: true, // This shows the back arrow
      ),
      body: Center(
        child: Text('Turnos Screen'),
      ),
    );
  }
}
