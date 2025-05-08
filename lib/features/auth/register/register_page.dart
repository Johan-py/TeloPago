import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();

  void _registerWithEmail() {
    final email = _emailController.text.trim();

    if (email.isNotEmpty) {
      // Aquí va lógica para crear cuenta con correo
      print('Registrando con correo: $email');

      // Ir a completar perfil y pasar el correo como argumento
      Navigator.pushNamed(
        context, 
        '/complete-profile', 
        arguments: email, // Pasar el correo como argumento
      );
    }
  }

  void _registerWithGoogle() {
    // Aquí conectarás Google Sign-In
    print('Registro con Google');
    
    // Ir a completar perfil
    Navigator.pushNamed(context, '/complete-profile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'Regístrate para comenzar',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),

            // Campo de correo
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // Botón: continuar con correo
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _registerWithEmail,
                child: const Text('Continuar con correo'),
              ),
            ),
            const SizedBox(height: 16),

            const Text('ó', style: TextStyle(fontSize: 16)),

            const SizedBox(height: 16),

            // Botón: continuar con Google
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.g_mobiledata),
                label: const Text('Continuar con Google'),
                onPressed: _registerWithGoogle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
