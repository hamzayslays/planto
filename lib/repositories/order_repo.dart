import '../data/network/network_api_services.dart';
import '../resources/app_url.dart';
import '../model/order_model.dart';

class OrderRepository {
  final _apiServices = NetworkApiService();

  Future<List<OrderModel>> fetchAllOrders() async {
    try {
      final response = await _apiServices.getGetApiResponse(
          AppUrl.getAllOrders);

      // response structure check karte hain
      // { "status": "success", "results": 0, "data": { "orders": [ ... ] } }
      final List<dynamic> orderList = response["data"]["orders"];

      return orderList.map((json) => OrderModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Failed to load orders: $e");
    }
  }
}
