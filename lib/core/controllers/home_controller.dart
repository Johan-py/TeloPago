import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class HomeController extends ChangeNotifier {
  final String baseUrl = 'http://10.0.2.2:8000/api/users';
  final String priceUrl = 'http://10.0.2.2:8000/api/prices/usdt-price/';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String? userName;
  double? balance;
  double? usdtPrice;
  bool isLoading = true;
  Timer? _priceTimer;

  Future<void> loadUserData() async {
    try {
      isLoading = true;
      notifyListeners();

      String? token = await _storage.read(key: 'auth_token');
      if (token == null) throw Exception('Token no encontrado');

      final url = Uri.parse('$baseUrl/me/');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 401) {
        final refreshed = await _refreshAccessToken();
        if (refreshed) {
          token = await _storage.read(key: 'auth_token');
          final retryResponse = await http.get(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          );

          if (retryResponse.statusCode == 200) {
            final data = jsonDecode(retryResponse.body);
            userName = data['nombre'] ?? 'Usuario';
            balance = double.tryParse(data['balance'].toString()) ?? 0.0;
          }
        } else {
          throw Exception('Token expirado y no se pudo refrescar');
        }
      } else if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        userName = data['nombre'] ?? 'Usuario';
        balance = double.tryParse(data['balance'].toString()) ?? 0.0;
      } else {
        throw Exception('Error al obtener datos del usuario');
      }

      // ✅ Iniciar polling si no está activo
      if (_priceTimer == null || !_priceTimer!.isActive) {
        _startPricePolling();
      }

      // 👇 Cargar precio una vez al inicio
      await loadUsdtPrice();

    } catch (e) {
      print('Error cargando datos: $e');
      userName = 'Invitado';
      balance = 0.0;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void loadUserName(String? fallbackName) {
    userName = fallbackName ?? 'Invitado';
    loadUserData();
  }

  void _startPricePolling() {
    _priceTimer?.cancel(); // Evita múltiples timers

    _priceTimer = Timer.periodic(const Duration(minutes: 1), (_) async {
      print('🔁 Ejecutando polling para precio USDT...');
      await loadUsdtPrice();
    });
  }

  Future<void> loadUsdtPrice() async {
    try {
      print('Intentando cargar precio USDT...');
      final response = await http
          .get(Uri.parse(priceUrl))
          .timeout(const Duration(seconds: 5)); // Timeout para prevenir bloqueos

      if (response.statusCode == 200) {
        print('Body de respuesta: ${response.body}');
        final data = jsonDecode(response.body);
        final parsedPrice = data['usdt_price_bs_average'] is num
            ? (data['usdt_price_bs_average'] as num).toDouble()
            : null;

        if (parsedPrice != null) {
          usdtPrice = parsedPrice;
          print('✅ Precio USDT actualizado: $usdtPrice');
          notifyListeners();
        } else {
          print('❌ No se pudo convertir a double desde: ${data['usdt_price_bs_average']}');
        }
      } else {
        print('⚠️ Error al obtener precio USDT: código ${response.statusCode}');
      }
    } on TimeoutException {
      print('⏰ Timeout al obtener precio USDT');
    } catch (e) {
      print('❌ Error obteniendo precio USDT: $e');
    }
  }

  @override
  void dispose() {
    _priceTimer?.cancel();
    super.dispose();
  }

  Future<bool> _refreshAccessToken() async {
    final refreshToken = await _storage.read(key: 'refresh_token');
    if (refreshToken == null) return false;

    final url = Uri.parse('$baseUrl/token/refresh/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccessToken = data['access'];
      if (newAccessToken != null) {
        await _storage.write(key: 'auth_token', value: newAccessToken);
        return true;
      }
    }
    return false;
  }
}
