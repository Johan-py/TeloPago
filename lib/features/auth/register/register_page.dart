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
      print('Registrando con correo: $email');

      Navigator.pushNamed(
        context,
        '/complete-profile',
        arguments: email,
      );
    }
  }

  void _registerWithGoogle() {
    print('Registro con Google');
    Navigator.pushNamed(context, '/complete-profile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Registro'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Regístrate para comenzar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),

            // Campo de correo
            TextField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                labelStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF2C2C2C),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // Botón: continuar con correo
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _registerWithEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25ADB6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Continuar con correo'),
              ),
            ),
            const SizedBox(height: 16),

            const Center(
              child: Text('ó', style: TextStyle(color: Colors.white70)),
            ),
            const SizedBox(height: 16),

            // Botón: continuar con Google
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.g_mobiledata, color: Colors.white),
                label: const Text(
                  'Continuar con Google',
                  style: TextStyle(color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white70),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _registerWithGoogle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
