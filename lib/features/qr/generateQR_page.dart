import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';
import 'package:telopago/core/controllers/home_controller.dart';

class QRGeneratorPage extends StatelessWidget {
  const QRGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el HomeController a través del Provider
    final homeController = context.watch<HomeController>();

    // Si los datos del usuario están cargados, se puede usar el nombre
    final userName = homeController.userName ?? 'Escanea para depositar'; // Si no hay nombre, se muestra 'Invitado'

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generador de QR'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Mostrar el nombre del usuario
              Text(
                ' $userName!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Mostrar el código QR
              const SizedBox(
                width: 200,
                height: 200,
                child: PrettyQr(
                  data: "https://telopago.vercel.app/",
                  errorCorrectLevel: QrErrorCorrectLevel.M,
                  roundEdges: true,
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  print('Guardar');
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
