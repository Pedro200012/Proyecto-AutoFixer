import 'package:flutter/material.dart';

class MetricasScreen extends StatelessWidget {
  const MetricasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metricas'),
        automaticallyImplyLeading: true, // This shows the back arrow
      ),
      body: Center(
        child: Text('Metricas Screen'),
      ),
    );
  }
}
