// payment_methods_view_model.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../resources/app_Url.dart';
import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../utils/utils.dart';

class PaymentMethodsViewModel extends ChangeNotifier {
  final  orderId;
  int selectedMethodIndex = -1;
  bool isLoading = false;

  PaymentMethodsViewModel({ this.orderId});

  final BaseApiServices _apiServices = NetworkApiService();

  void selectMethod(int index) {
    selectedMethodIndex = index;
    notifyListeners();
  }

  Future<bool> payNow(Map<String, dynamic> payload, BuildContext context) async {
    if (selectedMethodIndex == -1) {
      Utils.flushBarErrorMessage("Please select a payment method", context);
      return false;
    }

    isLoading = true;
    notifyListeners();

    String url = "";
    switch (selectedMethodIndex) {
      case 0:
        url = AppUrl.stripeCreateIntentUrl;
        break;
      case 1:
        url = AppUrl.easypaisaIntentUrl;
        break;
      case 2:
        url = AppUrl.jazzcashIntentUrl;
        break;
      default:
        Utils.flushBarErrorMessage("Invalid payment method", context);
        isLoading = false;
        notifyListeners();
        return false;
    }

    // Add orderId to payload
    payload['orderId'] = orderId;

    try {
      final response = await _apiServices.getPostApiResponse(url, payload);

      isLoading = false;
      notifyListeners();

      if (response['status'] == "success" || response['status'] == 200 || response['status'] == 201) {
        Utils.flushBarSuccessMessage("Payment successful", context);
        return true;
      } else {
        Utils.flushBarErrorMessage(response['message'] ?? "Payment failed", context);
        return false;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      Utils.flushBarErrorMessage("Payment error: $e", context);
      return false;
    }
  }




}
