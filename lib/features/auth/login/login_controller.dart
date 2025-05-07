import 'package:flutter/material.dart';
import 'package:telopago/core/services/auth_service.dart';

class LoginController {
  final AuthService _authService = AuthService();

  Future<void> login(String email, String password, BuildContext context) async {
    try {
      await _authService.login(email, password);
      // Navega a home
    } catch (e) {
      // Maneja errores
      print(e);
    }
  }
}
