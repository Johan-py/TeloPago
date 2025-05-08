
class AuthService {
  // Este sería el método simulado de registro, sin hacer una llamada HTTP real.
  Future<void> registerUser({
    required String name,
    required String email,
    required String carnet,
    required DateTime birthDate,
    required String password,
  }) async {
    try {
      // Simulación de un "registro exitoso" con datos en consola
      print('Registrando usuario...');
      print('Nombre: $name');
      print('Correo: $email');
      print('Carnet: $carnet');
      print('Fecha de nacimiento: ${birthDate.toIso8601String()}');
      print('Contraseña: $password');
      
      // Puedes simular un pequeño retardo para simular la operación de registro
      await Future.delayed(const Duration(seconds: 2));

      // Aquí simulas el éxito del registro
      print('Usuario registrado correctamente');

      // Si en el futuro deseas agregar validaciones, las puedes hacer aquí
      if (email.isEmpty || password.isEmpty || name.isEmpty) {
        throw Exception('Faltan datos');
      }

    } catch (e) {
      throw Exception('Error al registrar el usuario: $e');
    }
  }
}
