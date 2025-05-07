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
      appBar: AppBar(
        title: const Text('Selecciona un banco'),
        backgroundColor: const Color(0xFF25adb6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: banks.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // matriz 4x4
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final bank = banks[index];
            return GestureDetector(
              onTap: () {
                // Aquí puedes navegar o mostrar la opción del banco elegido
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Elegiste ${bank['name']}')),
                );
              },
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(245, 245, 245, 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(bank['logo']),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bank['name'],
                    style: const TextStyle(fontSize: 12),
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
