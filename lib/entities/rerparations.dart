import 'package:cloud_firestore/cloud_firestore.dart';

class Reparations {
  final String id;
  final String userid;
  final String vehicleid;
  final String state;
  final String typeService;
  final String enteryTurnid;
  final String exitTurnId;

  Reparations({required this.id, required this.userid, required this.typeService, required this.vehicleid, required this.state, required this.enteryTurnid, required this.exitTurnId});

  factory Reparations.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Reparations(
      id: doc.id,
      userid: data['userid'] ?? '',
      typeService: data['typeService'] ?? '',
      vehicleid: data['vehicleid'] ?? '',
      state: data['state'] ?? '',
      enteryTurnid: data['enteryTurnid'] ?? '',
      exitTurnId: data['exitTurnId'] ?? '',
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      'userid': userid,
      'typeService': typeService,
      'vehicleid': vehicleid,
      'state': state,
      'enteryTurnid': enteryTurnid,
      'exitTurnId': exitTurnId,
    };
  }
}