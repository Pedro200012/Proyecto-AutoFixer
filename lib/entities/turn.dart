import 'package:cloud_firestore/cloud_firestore.dart';

class Turn {
  final String id;
  final DateTime date;
  final String userId; 
  final String type;
  final String state;

  Turn({
    required this.id,
    required this.date,
    required this.userId, 
    required this.type,
    required this.state,
  });

  factory Turn.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Turn(
      id: doc.id,
      date: (data['date'] as Timestamp).toDate(),
      userId: data['userID'] as String, 
      type: data['type'] ?? '',
      state: data['state'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'date': date,
      'userID': userId, 
      'type': type,
      'state': state,
    };
  }
}
