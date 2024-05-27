import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:aplicacion_taller/entities/turn.dart';
import 'package:aplicacion_taller/entities/user.dart';

class TurnosScreen extends StatelessWidget {
  const TurnosScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Turnos'),
        automaticallyImplyLeading: true, // Esto muestra la flecha de retroceso
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:FirebaseFirestore.instance
                .collection('turns')
                .where('confirm', isEqualTo: true) 
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Algo salió mal'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          List<Turn> turns =
              data.docs.map((doc) => Turn.fromFirestore(doc)).toList();

          return _ListTurnView(turns: turns);
        },
      ),
    );
  }
}

class _ListTurnView extends StatelessWidget {
  final List<Turn> turns;

  const _ListTurnView({required this.turns});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: turns.length,
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
    String formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(turn.ingreso);

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(turn.userId)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        }
        if (snapshot.hasError) {
          return const Text('Error al cargar usuario');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text('Usuario no encontrado');
        }

        User user = User.fromFirestore(snapshot.data!);

        return Card(
          child: ListTile(
            title: Text(user.name),
            subtitle: Text(formattedDate),
          ),
        );
      },
    );
  }
}
