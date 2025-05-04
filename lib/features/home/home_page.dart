import 'package:flutter/material.dart';
import '../qr/qr_page.dart';
import '../settings/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildMainHomeView(),
      const QRPage(),
      const SettingsPage(),
    ];
  }

  Widget _buildMainHomeView() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          // Sección 1: Saludo y valor USDT
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('USDT: 15.92 Bs', style: TextStyle(fontSize: 18)),
                  Text('Hola, Johan 👋', style: TextStyle(fontSize: 16)),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.attach_money),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Sección 2: Balance
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(245, 245, 245, 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Balance disponible', style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text('Bs 850.00 / \$123.45',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Sección 3: Botón de pago
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/payments'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25adb6),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Pagar un servicio'),
            ),
          ),
          const SizedBox(height: 24),

          // Sección 4: Historial
          const Text('Historial de pagos', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              hintText: 'Filtrar por fecha',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFd3e9eb),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const ListTile(
              leading: Icon(Icons.payment),
              title: Text('AliExpress'),
              subtitle: Text('01/05/2025'),
              trailing: Text('- \$15.00'),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFd3e9eb),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const ListTile(
              leading: Icon(Icons.payment),
              title: Text('Recarga Tigo'),
              subtitle: Text('29/04/2025'),
              trailing: Text('- Bs 20.00'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TeloPago'),
        backgroundColor: const Color(0xFF25adb6),
      ),
      body: _pages.length > _selectedIndex
          ? _pages[_selectedIndex]
          : const SizedBox.shrink(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF25adb6),
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
      ),
    );
  }
}
