import 'package:flutter/material.dart';
import '../model/payment_model.dart';

class PaymentTile extends StatelessWidget {
  final PaymentMethod method;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentTile({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(method.icon, color: isSelected ? Colors.green : Colors.grey),
        title: Text(method.title),
        trailing: isSelected ? Icon(Icons.check_circle, color: Colors.green) : null,
      ),
    );
  }
}
