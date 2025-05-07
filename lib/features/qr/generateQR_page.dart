import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QRGeneratorPage extends StatefulWidget {
  @override
  _QRGeneratorPageState createState() => _QRGeneratorPageState();
}

class _QRGeneratorPageState extends State<QRGeneratorPage> {
  String userName = "Juan Pérez"; // Nombre del usuario (esto puede ser dinámico)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generador de QR'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Mostrar el nombre del usuario arriba del código QR
              Text(
                'Hola, $userName!', // Mostrar el nombre dinámicamente
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20), // Espacio entre el nombre y el código QR

              // Ajustar el tamaño con SizedBox o Container
              SizedBox(
                width: 200, // Ancho deseado
                height: 200, // Alto deseado
                child: PrettyQr(
                  data: "https://telopago.vercel.app/",
                  errorCorrectLevel: QrErrorCorrectLevel.M,
                  roundEdges: true, // Bordes redondeados (opcional)
                  // elementColor: Colors.blue, // Cambiar color (opcional)
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print('Guardar');
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
