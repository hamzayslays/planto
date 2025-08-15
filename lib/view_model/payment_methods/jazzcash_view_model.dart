import 'package:flutter/material.dart';
import '../../data/network/network_api_services.dart';
import '../../resources/app_Url.dart';


class JazzCashPaymentViewModel extends ChangeNotifier {
  final String orderId;
  JazzCashPaymentViewModel(this.orderId);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> processPayment(BuildContext context) async {
    _setLoading(true);

    try {
      final body = {"orderId": orderId, "currency": "usd"};
      final response = await NetworkApiService().getPostApiResponse(AppUrl.jazzcashIntentUrl, body);

      if (response != null && response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ JazzCash Payment Successful"), backgroundColor: Colors.green),
        );
      } else {
        throw Exception(response?['message'] ?? "Payment Failed");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Payment Failed: $e"), backgroundColor: Colors.red),
      );
    }

    _setLoading(false);
  }
}
