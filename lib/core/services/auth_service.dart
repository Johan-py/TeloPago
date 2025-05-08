import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = 'http://10.0.2.2:5001/telopago-dev/us-central1/api';

  Future<void> registerUser({
    required String name,
    required String email,
    required String carnet,
    required DateTime birthDate,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': name,
          'email': email,
          'carnet': carnet,
          'birthDate': birthDate.toIso8601String(),
          'password': password,
        }),
      );

      if (response.statusCode != 200) {
        final errorResponse = json.decode(response.body);
        throw Exception('Error: ${errorResponse['message']}');
      }

      print('Usuario registrado correctamente');
    } catch (e) {
      throw Exception('Error al registrar el usuario: $e');
    }
  }

  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/authenticate'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        print('Login exitoso');
        return json.decode(response.body);
      } else {
        final error = json.decode(response.body);
        throw Exception('Error al autenticar: ${error['message']}');
      }
    } catch (e) {
      throw Exception('Error al iniciar sesión: $e');
    }
  }
}
