import 'package:flutter/material.dart';
import '../features/auth/login/login_page.dart';
import '../features/auth/register/register_page.dart';
import '../features/auth/complete_profile/complete_profile_page.dart';
import '../features/home/home_page.dart';
import '../features/payments/payments_page.dart';
import '../features/payments/aliexpress_view.dart';
import '../features/qr/qr_page.dart';
import '../features/settings/settings_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => const LoginPage(),
  '/register': (context) => const RegisterPage(),
  '/complete-profile': (context) => const CompleteProfilePage(),
  '/home': (context) => const HomePage(),
  '/payments': (context) => const PaymentsPage(),
  '/payments/aliexpress': (context) => const AliExpressView(),
  '/qr': (context) => const QRPage(),
  '/settings': (context) => const SettingsPage(),
};

