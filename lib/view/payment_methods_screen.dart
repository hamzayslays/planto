import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../view/payment_methods/stripe_screen.dart';
import '../view/payment_methods/easy_paisa.dart';
import '../view/payment_methods/jazz_cash.dart';

class PaymentMethodsScreen extends StatelessWidget {
  final String orderId;
  const PaymentMethodsScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final paymentMethods = [
      {'title': 'Stripe', 'icon': Icons.credit_card},
      {'title': 'EasyPaisa', 'icon': Icons.account_balance_wallet},
      {'title': 'JazzCash', 'icon': Icons.account_balance},
      {'title': 'Cash on Delivery', 'icon': Icons.money},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Select Payment Method"), centerTitle: true, backgroundColor: Colors.green),
      body: ListView.builder(
        itemCount: paymentMethods.length,
        itemBuilder: (_, index) {
          return Card(
            child: ListTile(
              leading: Icon(paymentMethods[index]['icon'] as IconData),
              title: Text(paymentMethods[index]['title'].toString()),
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.push(context, MaterialPageRoute(builder: (_) => StripePaymentScreen(orderId: orderId)));
                    break;
                  case 1:
                    Navigator.push(context, MaterialPageRoute(builder: (_) => EasyPaisaPaymentScreen(orderId: orderId)));
                    break;
                  case 2:
                    Navigator.push(context, MaterialPageRoute(builder: (_) => JazzCashPaymentScreen(orderId: orderId)));
                    break;
                  case 3:
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cash on Delivery selected")));
                    break;
                }
              },
            ),
          );
        },
      ),
    );
  }
}
