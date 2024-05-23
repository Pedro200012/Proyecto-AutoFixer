import 'package:cloud_firestore/cloud_firestore.dart';

class Turn {
  final String id;
  final String date;
  final String hour;
  final String type;
  final String state;

  Turn({required this.id, required this.date, required this.hour, required this.type, required this.state});

  factory Turn.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Turn(
      id: doc.id,
      date: data['date'] ?? '',
      hour: data['hour'] ?? '',
      type: data['type'] ?? '',
      state: data['state'] ?? '',
    );
  }
    Map<String, dynamic> toFirestore() {
    return {
      'date': date,
      'hour': hour,
      'type': type,
      'state': state,
    };
  }
}
