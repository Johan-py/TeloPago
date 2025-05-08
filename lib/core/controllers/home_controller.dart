import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  String? _userName;
  String? get userName => _userName;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  // Modificar loadUserName para aceptar un nombre como argumento
  Future<void> loadUserName([String? name]) async {
    if (name != null) {
      // Si se pasa un nombre, asignarlo directamente
      _userName = name;
    } else {
      // Si no se pasa un nombre, intentar obtenerlo de Firebase
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        _userName = 'Invitado';
        _isLoading = false;
        notifyListeners();
        return;
      }

      try {
        final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (doc.exists && doc.data() != null && doc.data()!.containsKey('name')) {
          _userName = doc.data()!['name'];
        } else {
          _userName = 'Usuario';
        }
      } catch (e) {
        _userName = 'Usuario';
        debugPrint('Error al obtener el nombre del usuario: $e');
      }
    }

    // Finalizar el proceso de carga
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadUser() async {
    await loadUserName();
  }
}
