import 'package:flutter/material.dart';
import '../model/cart_item_model.dart';

class CartItemTileWidget extends StatelessWidget {
  final CartItemModel item;

  const CartItemTileWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(item.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
      title: Text(item.name),
      subtitle: Text("Quantity: ${item.quantity}"),
      trailing: Text("₹${item.price * item.quantity}"),
    );
  }
}
