import 'package:flutter/material.dart';

class PerfilesScreen extends StatelessWidget {
  const PerfilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfiles'),
        automaticallyImplyLeading: true, // This shows the back arrow
      ),
      body: Center(
        child: Text('Perfiles Screen'),
      ),
    );
  }
}
