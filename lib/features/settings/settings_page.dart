import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _showPlaceholder(BuildContext context, String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$action aún no implementado')),
    );
  }

  void _confirmDeleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Eliminar cuenta?'),
        content: const Text('Esta acción no se puede deshacer. ¿Estás seguro?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
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
      appBar: AppBar(title: const Text('Configuración')),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Editar perfil'),
            onTap: () => _showPlaceholder(context, 'Editar perfil'),
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Cambiar contraseña'),
            onTap: () => _showPlaceholder(context, 'Cambiar contraseña'), 
          ),
          ListTile(
            leading: const Icon(Icons.support_agent),
            title: const Text('Soporte'),
            onTap: () => _showPlaceholder(context, 'Soporte'),
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Eliminar cuenta'),
            textColor: Colors.red,
            iconColor: Colors.red,
            onTap: () => _confirmDeleteAccount(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar sesión'),
            onTap: () => _showPlaceholder(context, 'Cerrar sesión'),
          ),
        ],
      ),
    );
  }
}
