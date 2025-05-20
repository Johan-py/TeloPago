import 'package:flutter/material.dart';

class BankTransferPage extends StatelessWidget {
  const BankTransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> banks = [
      {'name': 'Banco Unión', 'logo': 'assets/images/bancounion.png'},
      {'name': 'BancoSol', 'logo': 'assets/images/bancosol.png'},
      {'name': 'BNB', 'logo': 'assets/images/bancobnb.png'},
      {'name': 'Económico', 'logo': 'assets/images/bancoeconomico.png'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF121212), // fondo oscuro
      appBar: AppBar(
        title: const Text('Selecciona un banco'),
        backgroundColor: const Color(0xFF25ADB6),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: banks.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75, // para que no queden muy altos los ítems
          ),
          itemBuilder: (context, index) {
            final bank = banks[index];
            return GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Elegiste ${bank['name']}'),
                    backgroundColor: const Color(0xFF25ADB6),
                  ),
                );
              },
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5), // fondo claro para destacar logo
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(bank['logo']),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    bank['name'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white, // texto blanco
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
