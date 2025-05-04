import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onLoginPressed() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Aquí conectarás Firebase más adelante
    print('Email: $email, Password: $password');
  }

  void _goToRegister() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 48),

            // Input: Usuario
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // Input: Contraseña
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),

            // Botón: Continuar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onLoginPressed,
                child: const Text('Continuar'),
              ),
            ),

            // Texto: ¿Olvidaste tu usuario o contraseña?
            TextButton(
              onPressed: () {
                // Puedes navegar a /recover más adelante
              },
              child: const Text('¿Olvidaste tu usuario o contraseña?'),
            ),

            const Spacer(),

            // Botón: Abre tu primera cuenta
            OutlinedButton(
              onPressed: _goToRegister,
              child: const Text('Abre tu primera cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
