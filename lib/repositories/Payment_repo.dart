



import '../data/network/network_api_services.dart';
import '../resources/app_Url.dart';

class PaymentRepository {
  final _apiServices = NetworkApiService();

  Future<dynamic> createPaymentIntent(Map<String, dynamic> data) async {
    try {
      final response = await _apiServices.getPostApiResponse(
        AppUrl.stripeCreateIntentUrl,
        data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> createCodPayment(String orderId) async {

    final payload = {"orderId": orderId};

    final response = await _apiServices.getPostApiResponse(
      AppUrl.cashOnDelIntentUrl,
      payload,
    );
    return response;
  }


}
