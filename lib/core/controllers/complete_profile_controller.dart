import 'dart:convert';
import 'package:http/http.dart' as http;

class CompleteProfileController {
  final String baseUrl = 'http://10.0.2.2:8000/api/users'; // Cambia según tu configuración

  Future<void> submitProfile({
    required String name,
    required String lastname,
    required String email,
    required String carnet,
    required DateTime birthDate,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/createusers/'); // Asumiendo endpoint /users/ para crear usuario
    final formattedDate =
            '${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}';

    final body = jsonEncode({
      'nombre': name,
      'apellido':lastname,
      'email': email,
      'carnet': carnet,
      'fecha_nacimiento': formattedDate,
      'password': password,
    });

    final headers = {'Content-Type': 'application/json'};

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode != 201) {
      // 201 Created es lo ideal
      throw Exception('Error creando usuario: ${response.body}');
    }
  }
}
