import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _showPlaceholder(BuildContext context, String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$action aún no implementado'),
        backgroundColor: Colors.grey[800],
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _confirmDeleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('¿Eliminar cuenta?', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Esta acción no se puede deshacer. ¿Estás seguro?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar', style: TextStyle(color: Colors.orange)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showPlaceholder(context, 'Cuenta eliminada');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // fondo oscuro
      appBar: AppBar(
        title: const Text('Configuración', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1F1F1F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text('Editar perfil', style: TextStyle(color: Colors.white)),
            onTap: () => _showPlaceholder(context, 'Editar perfil'),
          ),
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.white),
            title: const Text('Cambiar contraseña', style: TextStyle(color: Colors.white)),
            onTap: () => _showPlaceholder(context, 'Cambiar contraseña'),
          ),
          ListTile(
            leading: const Icon(Icons.support_agent, color: Colors.white),
            title: const Text('Soporte', style: TextStyle(color: Colors.white)),
            onTap: () => _showPlaceholder(context, 'Soporte'),
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text('Eliminar cuenta', style: TextStyle(color: Colors.red)),
            onTap: () => _confirmDeleteAccount(context),
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white),
            title: const Text('Cerrar sesión', style: TextStyle(color: Colors.white)),
            onTap: () => _showPlaceholder(context, 'Cerrar sesión'),
          ),
        ],
      ),
    );
  }
}
