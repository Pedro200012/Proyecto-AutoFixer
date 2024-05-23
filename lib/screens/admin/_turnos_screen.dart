import 'package:aplicacion_taller/entities/turn.dart';
import 'package:aplicacion_taller/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TurnosScreen extends StatelessWidget {
  const TurnosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Turnos'),
        automaticallyImplyLeading: true, // Esto muestra la flecha de retroceso
      ),
      // Usar StreamBuilder para escuchar los cambios en Firestore
      body: StreamBuilder<QuerySnapshot>(
        // Obtener la colección 'turns' desde Firestore
        stream: FirebaseFirestore.instance.collection('turns').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Algo salió mal'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Obtener los datos del snapshot
          final data = snapshot.requireData;

          // Convertir los datos del snapshot a una lista de objetos Turn
          List<Turn> turns =
              data.docs.map((doc) => Turn.fromFirestore(doc)).toList();

          // Pasar la lista de Turn a _ListTurnView
          return _ListTurnView(turns: turns);
        },
      ),
    );
  }
}

class _ListTurnView extends StatelessWidget {
  final List<Turn> turns;

  // Constructor para recibir la lista de Turn
  const _ListTurnView({required this.turns});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: turns.length, // Número de elementos en la lista
      itemBuilder: (context, index) {
        final turn = turns[index];
        return _TurnItem(turn: turn);
      },
    );
  }
}

class _TurnItem extends StatelessWidget {
  final Turn turn;

  const _TurnItem({required this.turn});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(turn.date);

    return FutureBuilder<DocumentSnapshot>(
        future: turn.userRef.get(), // Cargar el documento del usuario
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator(); // Mostrar un indicador de carga
          }
          if (snapshot.hasError) {
            return const Text('Error al cargar usuario');
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Text('Usuario no encontrado');
          }

          // Crear el objeto User desde el snapshot
          User user = User.fromFirestore(snapshot.data!);

          return Card(
              child: ListTile(
            title: Text(user.name), 
            subtitle: Text(formattedDate), 
          )
        );
      }
    );
  }
}
