import 'package:flutter/material.dart';
import 'package:planto/repositories/cart_repo.dart';
import 'package:planto/utils/utils.dart';
import 'package:provider/provider.dart';

import '../model/cart_item_model.dart';
import 'get_cart_view_model.dart';

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
    print("🟢 Retrieved userId: $userId");

    if (userId.isEmpty) {
      Utils.flushBarErrorMessage("User ID not found in local storage", context);
      setLoading(false);
      return;
    }

    final cartItem = CartItemModel(
      plantId: plantId,
      userId: userId,
      quantity: quantity,
      price: price,
      name: name,
      imageUrl: imageUrl,
    );

    _repo.addToCartApi(cartItem.toJson()).then((value) async {
      setLoading(false);
      Utils.flushBarSuccessMessage("Added to cart", context);

      /// 🔥 Trigger refresh in GetCartViewModel
      final getCartVM = Provider.of<GetCartViewModel>(context, listen: false);
      await getCartVM.fetchCartItems(userId); // refresh cart data

    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }


}
