import 'package:flutter/material.dart';
import 'package:planto/repositories/cart_repo.dart';
import 'package:planto/utils/utils.dart';

import '../model/cart_item_model.dart';

class CartViewModel extends ChangeNotifier {
  final CartRepository _repo = CartRepository();

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> addToCartApiHandler({
    required BuildContext context,
    required String plantId,
    required int quantity,
    required double price,
    required String name,
    required String imageUrl,
  }) async {
    setLoading(true);

    final userId = await Utils.getUserIdFromLocalStorage();

    final cartItem = CartItemModel(
      plantId: plantId,
      userId: userId,
      quantity: quantity,
      price: price,
    );

    _repo.addToCartApi(cartItem.toJson()).then((value) {
      setLoading(false);
      Utils.flushBarSuccessMessage("Added to cart", context);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  

}
