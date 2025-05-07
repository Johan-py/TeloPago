import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserProfile({
    required String name,
    required String email,
    required String carnet,
    required DateTime birthDate,
  }) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) throw Exception('Usuario no autenticado');

    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'carnet': carnet,
      'birthDate': birthDate.toIso8601String(),
    });
  }
}
