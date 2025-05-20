import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginController {
  final String baseUrl = 'http://10.0.2.2:8000/api/users';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Inicia sesión con email y password
  Future<void> loginWithEmail(String email, String password) async {
    final url = Uri.parse('$baseUrl/login/'); // Django SimpleJWT login

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final accessToken = data['access'];    // Token JWT de acceso
      final refreshToken = data['refresh'];  // Token de refresco

      if (accessToken == null) throw Exception('Access token no recibido');

      await _storage.write(key: 'auth_token', value: accessToken);
      if (refreshToken != null) {
        await _storage.write(key: 'refresh_token', value: refreshToken);
      }
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['detail'] ?? 'Error al iniciar sesión');
    }
  }

  /// Cierra sesión limpiando los tokens
  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
    await _storage.delete(key: 'refresh_token');
  }

  /// Devuelve el token de acceso almacenado
  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  /// Refresca el token de acceso usando el refresh token
  Future<bool> refreshAccessToken() async {
    final refreshToken = await _storage.read(key: 'refresh_token');
    if (refreshToken == null) return false;

    final url = Uri.parse('$baseUrl/token/refresh/');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccessToken = data['access'];
      if (newAccessToken != null) {
        await _storage.write(key: 'auth_token', value: newAccessToken);
        return true;
      }
    }

    return false;
  }
}
