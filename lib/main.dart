import 'package:flutter/material.dart';
import 'config/app_routes.dart';


void main() {
  runApp(const TeloPagoApp());
}

class TeloPagoApp extends StatelessWidget {
  const TeloPagoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeloPago',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', // Ruta inicial
      routes: appRoutes, // Aquí se agregan tus rutas
    );
  }
}
