import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../model/cart_item_model.dart';
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

  Future<List<CartItemModel>> getCartItems(String userId) async {
    try {
      // Correct URL format: append userId to the endpoint
      String url = '${AppUrl.getCartEndPointUrl}/$userId';
      print('📦 Fetching cart from: $url');

      dynamic response = await _apiServices.getGetApiResponse(url);

      if (response['data'] != null && response['data'] is List) {
        return response['data'].map<CartItemModel>((item) {
          return CartItemModel(
            plantId: item['plantId']['_id'] ?? '',
            name: item['plantId']['plantname'] ?? '',
            imageUrl: item['plantId']['image'] ?? '',
            price: (item['price'] ?? 0).toDouble(),
            quantity: item['quantity'] ?? 0,
            userId: item['userId'] ?? '',
          );
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("❌ Error in getCartItems: $e");
      rethrow;
    }
  }



}
