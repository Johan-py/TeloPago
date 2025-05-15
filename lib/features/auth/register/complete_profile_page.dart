import 'package:flutter/material.dart';
import '../../../core/controllers/complete_profile_controller.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  DateTime? _birthDate;

  final CompleteProfileController _controller = CompleteProfileController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Obtener el correo pasado como argumento desde la página anterior
    final String? email = ModalRoute.of(context)!.settings.arguments as String?;
    
    if (email != null) {
      _emailController.text = email; // Completar el campo de correo
    }
  }

  Future<void> _submitProfile() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final carnet = _idController.text.trim();
    final birth = _birthDate;
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || carnet.isEmpty || birth == null || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos.')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden.')),
      );
      return;
    }

    try {
      await _controller.submitProfile(
        name: name,
        email: email,
        carnet: carnet,
        birthDate: birth,
        password: password,
      );

      Future.microtask(() {
        // Navegar a la página de inicio, pasando el nombre como argumento
        Navigator.pushNamedAndRemoveUntil(
          context, 
          '/home', 
          (route) => false, 
          arguments: name, // Pasar el nombre como argumento
        );  
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18),
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (picked != null) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.white, // Fondo oscuro
      appBar: AppBar(
        title: const Text('Completa tu perfil'),
        backgroundColor: const Color(0xFF25ADB6), // Opcional: AppBar también oscuro
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const Text(
              'Introduce tus datos personales',
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold, 
                color: Colors.white, // Texto claro sobre fondo oscuro
              ),
            ),
            const SizedBox(height: 24),

            // Campo de nombre completo
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre completo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Campo de correo electrónico
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // Campo de número de carnet
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: 'Número de carnet',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Selector de fecha de nacimiento
            GestureDetector(
              onTap: _pickBirthDate,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Fecha de nacimiento',
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  _birthDate != null
                      ? '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}'
                      : 'Selecciona una fecha',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Campo de contraseña
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true, // Ocultar el texto ingresado
            ),
            const SizedBox(height: 16),

            // Campo de confirmación de contraseña
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirmar contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true, // Ocultar el texto ingresado
            ),
            const SizedBox(height: 32),

            // Botón para completar el registro
            ElevatedButton(
              onPressed: _submitProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF25ADB6), // Color de fondo personalizado
                foregroundColor: Colors.white,      // Color del texto
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Bordes redondeados opcionales
                ),
              ),
              child: const Text('Finalizar registro'),
            ),

                      ],
        ),
      ),
    );
  }
}
