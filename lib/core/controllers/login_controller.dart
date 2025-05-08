import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;

  /// Inicia sesión con email y contraseña
  Future<void> loginWithEmailPassword(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Debes completar ambos campos');
    }

    try {
      isLoading = true;
      notifyListeners();

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(_getErrorMessage(e));
    } catch (e) {
      throw Exception('Error al iniciar sesión: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Usuario no encontrado';
      case 'wrong-password':
        return 'Contraseña incorrecta';
      case 'invalid-email':
        return 'Correo inválido';
      default:
        return 'Error de autenticación: ${e.message}';
    }
  }
}
