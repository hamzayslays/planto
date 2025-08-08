import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cart_item_model.dart';
import '../repositories/cart_repo.dart';
import 'delete_cart_view_model.dart';

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
      final fetchedItems = await _repo.getCartItems(userId);

      // 🔁 Map to merge duplicate plantIds
      final Map<String, CartItemModel> mergedItems = {};

      for (var item in fetchedItems) {
        if (mergedItems.containsKey(item.plantId)) {
          // 🔁 If plant already exists → update quantity
          final existing = mergedItems[item.plantId]!;
          mergedItems[item.plantId] = CartItemModel(
            plantId: item.plantId,
            userId: item.userId,
            name: item.name,
            imageUrl: item.imageUrl,
            price: item.price,
            quantity: existing.quantity + item.quantity,
          );
        } else {
          // ➕ Add new plant to map
          mergedItems[item.plantId] = item;
        }
      }

      _cartItems = mergedItems.values.toList();

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

  Future<void> fetchCartUsingPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId != null) {
      await fetchCartItems(userId);
    } else {
      debugPrint("User ID not found");
    }
  }

  Future<void> deleteAndRefreshItem(String plantId, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    if (userId == null) return;

    final deleteProvider = DeleteCartViewModel();
    await deleteProvider.deleteCartItem(userId, plantId, context);
    await fetchCartItems(userId);
  }



}
