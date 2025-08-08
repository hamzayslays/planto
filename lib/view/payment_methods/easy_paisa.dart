// easypaisa_payment_screen.dart
import 'package:flutter/material.dart';

class EasyPaisaPaymentScreen extends StatelessWidget {
  const EasyPaisaPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("EasyPaisa Payment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: "Phone Number",
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call EasyPaisa API here
              },
              child: const Text("Pay Now"),
            )
          ],
        ),
      ),
    );
  }
}
