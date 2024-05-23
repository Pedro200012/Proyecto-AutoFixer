import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

class Turn {
  final String id;
  final DateTime date;
  final DocumentReference userRef;
  final String type;
  final String state;
  late User user;

  Turn({required this.id, required this.date, required this.userRef, required this.type, required this.state});

  factory Turn.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Turn(
      id: doc.id,
      date: (data['date'] as Timestamp).toDate(),
      userRef: data['user'] as DocumentReference,
      type: data['type'] ?? '',
      state: data['state'] ?? '',
    );
  }

  // Método para cargar los datos del usuario desde la referencia
  Future<void> loadUser() async {
    final userData = await userRef.get();
    user = User.fromFirestore(userData); // Aquí usamos directamente el DocumentSnapshot
  }

  Map<String, dynamic> toFirestore() {
    return {
      'date': date,
      'user': userRef,
      'type': type,
      'state': state,
    };
  }
}
