import '../../data/network/network_api_service.dart';
import '../../resources/app_url.dart';

class StripePaymentRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> createPaymentIntent(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.postApiResponse(
        AppUrl.stripeCreateIntentUrl,
        data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
