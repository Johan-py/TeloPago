import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/controllers/home_controller.dart'; // Importa HomeController
import './config/app_routes.dart'; // Asegúrate de que esté bien la ruta

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
         // Agrega HomeController
      ],
      child: const TeloPagoApp(),
    ),
  );
}

class TeloPagoApp extends StatelessWidget {
  const TeloPagoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeloPago',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: appRoutes, // Aquí usas el mapa que definiste en app_routes.dart
    );
  }
}
