import 'package:flutter/material.dart';

class QRPage extends StatelessWidget {
  const QRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escanear QR')),
      body: const Center(
        child: Text(
          'Aquí se mostrará el escáner de código QR',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
