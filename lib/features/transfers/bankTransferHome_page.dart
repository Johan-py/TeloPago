import 'package:flutter/material.dart';
import 'package:telopago/features/qr/generateQR_page.dart';
import 'bankTransfer_page.dart'; 
import '../qr/qr_page.dart';      
class TransferOptionsPage extends StatelessWidget {
  const TransferOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferencias'),
        backgroundColor: const Color(0xFF25adb6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BankTransferPage()),
                );
              },
              icon: const Icon(Icons.account_balance),
              label: const Text('Transferir por banco'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25adb6),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const QRPage()),
                );
              },
              icon: const Icon(Icons.qr_code),
              label: const Text('Transferir por QR'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25adb6),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // Navegar a la página QR cuando se presione el botón
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) =>  QRGeneratorPage()),
                );
              },
              icon: const Icon(Icons.attach_money),
              label: const Text('Depositar a cuenta'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25adb6),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),

          ],
        ),
      ),
    );
  }
}