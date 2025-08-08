import 'package:flutter/material.dart';
import 'package:planto/utils/utils.dart';
import '../../model/payment_model.dart';

class StripePaymentViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  String cardName = "";
  String cardNumber = "";
  String expiryMonth = "";
  String expiryYear = "";
  String cvc = "";
  String email = "";

  void saveCardName(String val) => cardName = val;
  void saveCardNumber(String val) => cardNumber = val;
  void saveExpiryMonth(String val) => expiryMonth = val;
  void saveExpiryYear(String val) => expiryYear = val;
  void saveCVC(String val) => cvc = val;
  void saveEmail(String val) => email = val;

  Future<void> processPayment(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      final paymentData = PaymentModel(
        cardName: cardName,
        cardNumber: cardNumber,
        expiryMonth: expiryMonth,
        expiryYear: expiryYear,
        cvc: cvc,
        email: email,
      );

      // here we will call stripe API
     Utils.flushBarSuccessMessage('Info saved successfully', context);
    }
  }
}
