import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';
import 'package:telopago/core/controllers/home_controller.dart';

class QRGeneratorPage extends StatelessWidget {
  const QRGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = context.watch<HomeController>();
    final userName = homeController.userName ?? 'Escanea para depositar';

    return Scaffold(
      backgroundColor: const Color(0xFF121212), // fondo oscuro
      appBar: AppBar(
        title: const Text('Generador de QR'),
        backgroundColor: const Color(0xFF25ADB6),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ' $userName!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // texto blanco
                ),
              ),
              const SizedBox(height: 20),

              // QR con color blanco para que contraste sobre fondo oscuro
              const SizedBox(
                width: 200,
                height: 200,
                child: PrettyQr(
                  data: "ToI9BfoN07c0bZjZjXtXJ/RukFX67b2PgeN//27aQ6RBNPce90sNiqJadgQ2RyeaB0yGRU6mKgRfU5XSGkAd6IONdZpioQpzU1JAGouqfTZ1LNly1C/NRrSzIwt2wDmSCLrPMKIoj570F9YWUThZtLboenVUq3rBhyKlw27ITbqxPI1EokWxu7haTez6qa1BJJf1lH/lyLjUViY3FQN5x/tBECirRZt0fV21sJ53jK4n4hXSd8Uo+qcZn9QLroj9tp8pJaJUaMu11Fcqs5fSXIcsmlYH2v/FMEfNSDVFi1DfG0SHMCRDLQs6mizTcLvA0eM3hgKF9rsJvX6q5QoGFw==|772E2FC6B3BAA5262DA3FE4B",
                  errorCorrectLevel: QrErrorCorrectLevel.M,
                  roundEdges: true,
                  elementColor: Colors.white, // color blanco en el QR
                  // backgroundColor: Colors.transparent, // opcional si quieres fondo transparente
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  print('Guardar');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25ADB6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
