import 'package:flutter/material.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> allServices = ['AliExpress', 'Netflix', 'Spotify', 'Amazon'];
  List<String> filteredServices = [];

  @override
  void initState() {
    super.initState();
    filteredServices = List.from(allServices);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredServices = allServices
          .where((service) => service.toLowerCase().contains(query))
          .toList();
    });
  }

  void _handleServiceTap(String service) {
    if (service == 'AliExpress') {
      Navigator.pushNamed(context, '/payments/aliexpress');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$service aún no está disponible')),
      );
    }
  }

  Widget _buildServiceTile(String service) {
    final Map<String, String> icons = {
      'AliExpress': 'assets/images/aliexpress.png',
      'Netflix': 'assets/images/netflix.png',
      'Spotify': 'assets/images/Spotify.png',
      'Amazon': 'assets/images/amazon.png',
    };

    return GestureDetector(
      onTap: () => _handleServiceTap(service),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icons[service] != null
                ? Image.asset(
                    icons[service]!,
                    width: 48,
                    height: 48,
                    errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                  )
                : const Icon(Icons.miscellaneous_services, size: 48),
            const SizedBox(height: 8),
            Text(service, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagar servicios')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Buscador
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar servicio',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            // Cuadrícula de servicios
            Expanded(
              child: GridView.builder(
                itemCount: filteredServices.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columnas
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final service = filteredServices[index];
                  return _buildServiceTile(service);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
