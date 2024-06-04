import 'package:aplicacion_taller/entities/turn.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class TurnoDetailsScreen extends StatefulWidget {
  final Turn turn;
  const TurnoDetailsScreen({super.key, required this.turn});

  @override
  _TurnoDetailsScreenState createState() => _TurnoDetailsScreenState();
}

class _TurnoDetailsScreenState extends State<TurnoDetailsScreen> {
  late String _selectedState;
  final List<String> _states = ['pending', 'confirm', 'in progress', 'done'];

  @override
  void initState() {
    super.initState();
    // Verifica que el estado inicial sea válido, si no, asigna un valor predeterminado
    _selectedState =
        _states.contains(widget.turn.state) ? widget.turn.state : _states[0];
  }

  void _updateTurnState() async {
    try {
      await FirebaseFirestore.instance
          .collection('turns')
          .doc(widget.turn.id)
          .update({'state': _selectedState});
    } catch (e) {
      print('Error al actualizar el estado del turno: $e');
    }
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Turno'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID del Turno: ${widget.turn.id}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Fecha de Ingreso: ${widget.turn.ingreso}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            const Text('Estado:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: _selectedState,
              items: _states.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedState = newValue!;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateTurnState,
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
