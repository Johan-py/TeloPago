import 'package:flutter/material.dart';

class AliExpressView extends StatefulWidget {
  const AliExpressView({super.key});

  @override
  State<AliExpressView> createState() => _AliExpressViewState();
}

class _AliExpressViewState extends State<AliExpressView> {
  final TextEditingController _linkController = TextEditingController();
  bool _isVerifying = false;

  Future<void> _submit() async {
    final link = _linkController.text.trim();

    if (link.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa el campo del enlace')),
      );
      return;
    }

    setState(() => _isVerifying = true);

    // Simular proceso de verificación
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isVerifying = false);

    // Mostrar diálogo de éxito
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Verificado ✅'),
        content: const Text('El producto ha sido verificado exitosamente.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pago AliExpress')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const SizedBox(height: 32),
            const Icon(Icons.shopping_bag, size: 80, color: Colors.orange),
            const SizedBox(height: 24),
            const Text(
              'Pega el enlace del producto de AliExpress',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),

            TextField(
              controller: _linkController,
              decoration: const InputDecoration(
                labelText: 'Enlace del producto',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),

            ElevatedButton.icon(
              onPressed: _isVerifying ? null : _submit,
              icon: _isVerifying
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.verified),
              label: Text(_isVerifying ? 'Verificando...' : 'Verificar'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
