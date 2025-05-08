import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telopago/core/controllers/home_controller.dart';
import '../qr/qr_page.dart';
import '../settings/settings_page.dart';
import '../transfers/bankTransferHome_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? name = ModalRoute.of(context)?.settings.arguments as String?;

    return ChangeNotifierProvider(
      create: (_) {
        final controller = HomeController();
        controller.loadUserName(name); // Cargar el nombre si está disponible
        return controller;
      },
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  Widget _buildMainHomeView() {
    final controller = context.watch<HomeController>(); // Uso de watch para valores reactivos
    final name = controller.userName ?? 'Invitado'; // Si no hay nombre, se muestra 'Invitado'

    // Se muestra un mensaje de carga mientras se obtiene el nombre
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          // Sección 1: Saludo y valor USDT
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('USDT: 15.92 Bs', style: TextStyle(fontSize: 18)),
                  Text('Hola, $name 👋', style: const TextStyle(fontSize: 16)),
                ],
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 30, 134, 231),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.attach_money, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TransferOptionsPage()),
                    );
                  },
                  padding: EdgeInsets.zero,
                  iconSize: 30,
                ),
              )
            ],
          ),
          const SizedBox(height: 24),

          // Sección 2: Balance
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 189, 224, 226),
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
                backgroundColor: const Color.fromARGB(255, 101, 211, 219),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Pagar un servicio'),
            ),
          ),
          const SizedBox(height: 24),

          // Sección 4: Historial
          const Text('Últimos movimientos', style: TextStyle(fontSize: 18)),
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
    final pages = [
      _buildMainHomeView(),
      const QRPage(),
      const SettingsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('TeloPago'),
        backgroundColor: const Color.fromARGB(255, 101, 211, 219),
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      body: pages[_selectedIndex],
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
