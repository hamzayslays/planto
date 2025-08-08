import 'package:flutter/material.dart';

class PaymentMethod{
  final String title;
  final IconData icon;
  final String type;

  PaymentMethod({
    required this.title,
    required this.icon,
    required this.type,});

}

class PaymentModel {
  final String cardName;
  final dynamic cardNumber;
  final dynamic expiryMonth;
  final dynamic expiryYear;
  final dynamic cvc;
  final String? email;


  PaymentModel({
    required this.cardName,
    required this.cardNumber,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cvc,
    this.email,

  });
}
