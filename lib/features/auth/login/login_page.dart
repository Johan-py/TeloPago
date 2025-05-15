import 'package:flutter/material.dart';
import '../../../core/controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final LoginController _controller = LoginController();

  void _onLoginPressed() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      await _controller.loginWithEmailPassword(email, password);
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  void _goToRegister() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Fondo oscuro
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo + Nombre
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/teloPago.png',
                  height: 48,
                ),
                const SizedBox(width: 12),
                const Text(
                  'TeloPago',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),

            // Input: Correo electrónico
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

            // Input: Contraseña
            TextField(
              controller: _passwordController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Contraseña',
                labelStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF2C2C2C),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),

            // Botón: Iniciar sesión
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onLoginPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25ADB6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Iniciar sesión'),
              ),
            ),

            // Texto: ¿Olvidaste tu usuario o contraseña?
            TextButton(
              onPressed: () {
                // Puedes navegar a /recover más adelante
              },
              child: const Text(
                '¿Olvidaste tu usuario o contraseña?',
                style: TextStyle(color: Colors.white70),
              ),
            ),

            const Spacer(),

            // Botón: Abre tu cuenta
            OutlinedButton(
              onPressed: _goToRegister,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white70),
                foregroundColor: Colors.white,
              ),
              child: const Text('Abre tu primera cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
