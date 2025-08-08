import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view_model/delete_cart_view_model.dart';
import '../view_model/get_cart_view_model.dart';
import '../widgets/cart_tile.dart';
import 'check_out_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Set<String> selectedItems = {};

  double _calculateSelectedTotal(GetCartViewModel provider) {
    return provider.cartItems
        .where((item) => selectedItems.contains(item.plantId))
        .fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetCartViewModel>(
        context,
        listen: false,
      ).fetchCartUsingPrefs();
    });
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
          style: TextStyle(color: Colors.white, fontSize: 22.sp),
        ),
      ),
      body:
          cartProvider.isLoading
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
                    onDelete: (_, _) async {
                      await cartProvider.deleteAndRefreshItem(
                        item.plantId,
                        context,
                      );
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
        color: Colors.green.shade50,
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
            'Total: Rs/= ${_calculateSelectedTotal(cartProvider).toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),

          InkWell(
            onTap: () async {

              if (selectedItems.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please select at least one item."),
                  ),
                );
                return;
              }

              final selectedCartItems =
                  cartProvider.cartItems
                      .where((item) => selectedItems.contains(item.plantId))
                      .toList();
              for (var item in selectedCartItems) {
                print("${item.name} x${item.quantity}");
              }
              setState(() => selectedItems.clear());

              Navigator.push(context, MaterialPageRoute(builder: (_)=> CheckOutScreen(selectedItems: selectedCartItems)  ));

            },
            child: Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(color: Colors.green.shade500,
              borderRadius: BorderRadius.circular(12.r)
              ),
              child: Center(
                child: Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
