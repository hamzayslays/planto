import 'package:flutter/material.dart';

import '../repositories/del_cart_repo.dart';

class DeleteCartViewModel extends ChangeNotifier {
  final _deleteCartRepo = DeleteCartRepository();

  bool _isDeleting = false;
  bool get isDeleting => _isDeleting;

  void setDeleting(bool value) {
    _isDeleting = value;
    notifyListeners();
  }

  Future<void> deleteCartItem(String userId, String plantId, BuildContext context) async {
    setDeleting(true);
    try {
      final response = await _deleteCartRepo.deleteCartItem(userId, plantId);

      // Optional: Show confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item removed from cart')),
      );

      // Optional: handle response
      print("Delete Response: $response");
    } catch (e) {
      print("Delete Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete item')),
      );
    } finally {
      setDeleting(false);
    }
  }
}
