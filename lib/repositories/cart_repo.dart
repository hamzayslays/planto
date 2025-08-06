import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../resources/app_url.dart';

class CartRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> addToCartApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
        AppUrl.addToCartEndPointUrl,
        data,
      );
      return response;
    } catch (e) {
      print('error-----------> $e');
    }
  }

  Future<dynamic> getCartItems(String userId) async {
    try {
      String url = AppUrl.getCartEndPointUrl + userId;
      dynamic response = await _apiServices.getGetApiResponse(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }


}
