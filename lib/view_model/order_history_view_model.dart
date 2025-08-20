import 'package:flutter/material.dart';
import '../data/reponse/api_response.dart';
import '../model/get_all_orders.dart';
import '../repositories/order_repo.dart';

class OrderHistoryViewModel with ChangeNotifier {
  final _repo = OrderRepository();

  ApiResponse<List<Orders>> orders = ApiResponse.loading();

  Future<void> fetchOrders() async {
    orders = ApiResponse.loading();
    notifyListeners();

    try {
      final fetchedOrders = await _repo.fetchUserOrders();
      orders = ApiResponse.completed(fetchedOrders);
    } catch (e) {
      orders = ApiResponse.error(e.toString());
    }

    notifyListeners();
  }
}
