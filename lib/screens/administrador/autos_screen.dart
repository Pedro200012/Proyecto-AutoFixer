import 'package:flutter/material.dart';

class AutosScreen extends StatelessWidget {
  const AutosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Autos'),
        automaticallyImplyLeading: true, // This shows the back arrow
      ),
      body: Center(
        child: Text('Autos Screen'),
      ),
    );
  }
}
