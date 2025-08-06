import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/get_cart_view_model.dart';
import '../widgets/cart_tile.dart';

class CartScreen extends StatefulWidget {
  final String userId;
  const CartScreen({super.key, required this.userId});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<GetCartViewModel>(context, listen: false)
        .fetchCartItems(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<GetCartViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: cartProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: cartProvider.cartItems.length,
        itemBuilder: (context, index) {
          return CartItemTileWidget(item: cartProvider.cartItems[index]);
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Total: ₹${cartProvider.totalPrice.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
