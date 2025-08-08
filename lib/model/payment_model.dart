import 'package:flutter/material.dart';

class PaymentMethod {
  final String title;    // display name
  final IconData icon;   // icon for UI
  final String type;

  const PaymentMethod({
    required this.title,
    required this.icon,
    required this.type,
  });
}
