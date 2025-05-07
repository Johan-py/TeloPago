import 'package:flutter/material.dart';
import 'package:telopago/firebase_options.dart';
import 'config/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
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
