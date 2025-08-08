import 'package:flutter/cupertino.dart';

import '../model/cart_item_model.dart';

class CheckOutViewModel extends ChangeNotifier {
  List<CartItemModel> selectedItems;   // Keep only one declaration
  int selectedMethodIndex = -1;
  double deliveryFee = 0;

  CheckOutViewModel(this.selectedItems);

  double get subTotal {
    return selectedItems.fold(
      0,
          (sum, item) => sum + (item.price * item.quantity),
    );
  }


  double get total => subTotal + deliveryFee;

  void selectMethod(int index) {
    selectedMethodIndex = index;
    notifyListeners();
  }

  Future<bool> placeOrder() async {
    if (selectedMethodIndex == -1) return false;

    // Prepare order data
    final orderData = {
      'paymentMethod': selectedMethodIndex,
      'items': selectedItems.map((e) => e.toJson()).toList(),
      // Add more order details as needed
    };

    // Call your create order API here
    // Example:
    // final response = await ApiService.createOrder(orderData);
    // return response.success;

    // For demo, return true after delay
    await Future.delayed(Duration(seconds: 1));
    return true;
  }
}
