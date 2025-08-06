import 'package:flutter/material.dart';
import '../model/cart_item_model.dart';
import '../repositories/cart_repo.dart';

class GetCartViewModel with ChangeNotifier {
  final CartRepository _repo = CartRepository();

  List<CartItemModel> _cartItems = [];
  bool _isLoading = false;

  List<CartItemModel> get cartItems => _cartItems;
  bool get isLoading => _isLoading;

  Future<void> fetchCartItems(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _cartItems = await _repo.getCartItems(userId);
    } catch (e) {
      print("Error fetching cart: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  double get totalPrice =>
      _cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  void deleteCartItem(String userId, String plantId) {
    // TODO: Call the real API here
    print("Delete called for userId: $userId and plantId: $plantId");
  }



}
