import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view_model/delete_cart_view_model.dart';
import '../view_model/get_cart_view_model.dart';
import '../widgets/cart_tile.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Set<String> selectedItems = {};

  @override
  void initState() {
    super.initState();
    _fetchCartData();
  }

  Future<void> _fetchCartData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId != null) {
      Provider.of<GetCartViewModel>(context, listen: false)
          .fetchCartItems(userId);
    } else {
      debugPrint("User ID not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<GetCartViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.shade500,
        centerTitle: true,
        title: Text(
          'Your Cart',
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
      ),
      body: cartProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartProvider.cartItems.isEmpty
          ? const Center(child: Text("No items in cart"))
          : ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        itemCount: cartProvider.cartItems.length,
        itemBuilder: (context, index) {
          final item = cartProvider.cartItems[index];

          return CartItemTileWidget(
            item: item,
            isSelected: selectedItems.contains(item.plantId),
            onCheckboxChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  selectedItems.add(item.plantId);
                } else {
                  selectedItems.remove(item.plantId);
                }
              });
            },
            onDelete: (userId, plantId) async {
              final deleteProvider = Provider.of<DeleteCartViewModel>(
                context,
                listen: false,
              );

              await deleteProvider.deleteCartItem(
                userId,
                plantId,
                context,
              );

              Provider.of<GetCartViewModel>(
                context,
                listen: false,
              ).fetchCartItems(userId);
            },
          );
        },
      ),
      bottomNavigationBar: _buildBottomBar(cartProvider),
    );
  }

  Widget _buildBottomBar(GetCartViewModel cartProvider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total: Rs/= ${cartProvider.totalPrice.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Checkout functionality coming soon!'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Checkout',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
