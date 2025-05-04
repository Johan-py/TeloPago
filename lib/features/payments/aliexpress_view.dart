import 'package:flutter/material.dart';

class AliExpressView extends StatefulWidget {
  const AliExpressView({super.key});

  @override
  State<AliExpressView> createState() => _AliExpressViewState();
}

class _AliExpressViewState extends State<AliExpressView> {
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _submit() {
    final link = _linkController.text.trim();
    final amount = _amountController.text.trim();

    if (link.isEmpty || amount.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos')),
      );
      return;
    }

    // Aquí se puede integrar con Firebase más adelante
    print('Pagando AliExpress con link: $link y monto: $amount');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Solicitud enviada ✅')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pago AliExpress')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const SizedBox(height: 32),
            const Icon(Icons.shopping_bag, size: 80, color: Colors.orange),
            const SizedBox(height: 24),
            const Text(
              'Paga tu producto de AliExpress',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),

            TextField(
              controller: _linkController,
              decoration: const InputDecoration(
                labelText: 'Enlace del producto',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // TextField(
            //   controller: _amountController,
            //   keyboardType: TextInputType.numberWithOptions(decimal: true),
            //   decoration: const InputDecoration(
            //     labelText: 'Monto en USD',
            //     border: OutlineInputBorder(),
            //     prefixText: '\$ ',
            //   ),
            // ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.accessibility),
              label: const Text('Verificar'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
