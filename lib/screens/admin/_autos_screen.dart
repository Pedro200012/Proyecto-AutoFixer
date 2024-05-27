import 'package:flutter/material.dart';

class AutosScreen extends StatelessWidget {
  const AutosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autos'),
        automaticallyImplyLeading: true, // This shows the back arrow
      ),
      body: const Center(
        child: Text('Autos Screen'),
      ),
    );
  }
}
