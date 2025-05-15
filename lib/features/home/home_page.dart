import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telopago/core/controllers/home_controller.dart';
import 'package:telopago/features/qr/generateQR_page.dart';
import 'package:telopago/features/transfers/bankTransfer_page.dart';
import '../qr/qr_page.dart';
import '../settings/settings_page.dart';
import '../payments/payments_page.dart'; // Ajusta la ruta según tu estructura

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? name = ModalRoute.of(context)?.settings.arguments as String?;

    return ChangeNotifierProvider(
      create: (_) {
        final controller = HomeController();
        controller.loadUserName(name);
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
    final controller = context.watch<HomeController>();
    final name = controller.userName ?? 'Invitado';

    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Bienvenida y perfil
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bienvenido(a)',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(Icons.emoji_events, color: Colors.white70, size: 16),
                      SizedBox(width: 4),
                      Text('Priority', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ],
              ),
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/user_default.png'), // Usa tu imagen aquí
                radius: 24,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Balance Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF25adb6), Color(0xFF1c2e35)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '\$5,500.50',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Balance',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Bs 88,008\n123-456-7890', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                    Icon(Icons.qr_code, color: Colors.white, size: 32),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BankTransferPage()),
                  );
                },
                child: const _ActionButton(icon: Icons.attach_money, label: 'T Banco'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QRGeneratorPage()),
                  );
                },
                child: const _ActionButton(icon: Icons.request_page, label: 'Depositar'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QRPage()),
                  );
                },
                child: const _ActionButton(icon: Icons.qr_code_scanner, label: 'Scan'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaymentsPage()),
                  );
                },
                child: const _ActionButton(icon: Icons.swap_horiz, label: 'Servicios'),
              ),
              const _ActionButton(icon: Icons.more_horiz, label: 'Más'),
            ],
          ),
          const SizedBox(height: 24),

          // Search bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: const TextStyle(color: Colors.white60),
              prefixIcon: const Icon(Icons.search, color: Colors.white60),
              filled: true,
              fillColor: const Color(0xFF2c2c2c),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 16),

          // Últimos movimientos
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Últimos movimientos', style: TextStyle(fontSize: 16, color: Colors.white)),
              Text('Ver todos', style: TextStyle(color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 12),

          const _TransactionTile(name: 'NETFLIX', date: '04 Abril 2024 - 10:23', amount: 'USD 7,99', isNegative: false),
          const _TransactionTile(name: 'META ADS', date: '04 Abril 2024 - 10:23', amount: 'USD 7,99', isNegative: false),
          const _TransactionTile(name: 'META ADS', date: '04 Abril 2024 - 10:23', amount: 'USD 7,99', isNegative: true),
          const _TransactionTile(name: 'META ADS', date: '04 Abril 2024 - 10:23', amount: 'USD 7,99', isNegative: false),
          const _TransactionTile(name: 'META ADS', date: '04 Abril 2024 - 10:23', amount: 'USD 7,99', isNegative: true),
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
      backgroundColor: const Color(0xFF1e1e1e),
      appBar: AppBar(
        backgroundColor: const Color(0xFF25adb6),
        title: const Text('TeloPago', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF25adb6),
        unselectedItemColor: Colors.white54,
        backgroundColor: const Color(0xFF2c2c2c),
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'QR'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
      ),
    );
  }
}

// Acción principal (Transfer, Request, etc.)
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF25adb6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}

// Componente de movimiento
class _TransactionTile extends StatelessWidget {
  final String name;
  final String date;
  final String amount;
  final bool isNegative;

  const _TransactionTile({
    required this.name,
    required this.date,
    required this.amount,
    required this.isNegative,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: Colors.teal),
        ListTile(
          title: Text(name, style: const TextStyle(color: Colors.white)),
          subtitle: Text(date, style: const TextStyle(color: Colors.white60)),
          trailing: Text(
            amount,
            style: TextStyle(
              color: isNegative ? Colors.redAccent : Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
