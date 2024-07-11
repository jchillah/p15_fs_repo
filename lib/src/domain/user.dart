import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;

  User({
    required this.uid,
    required this.email,
  });

  // Konvertiere User-Objekt in ein Map-Objekt
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }

  // Erzeuge ein User-Objekt aus einem Map-Objekt
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      email: map['email'],
    );
  }

  // Konvertiere User-Objekt in ein Firestore Document Snapshot
  Stream<DocumentSnapshot<Map<String, dynamic>>> toDocument() {
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }
}
