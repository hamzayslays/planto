import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../model/cart_item_model.dart';
import '../view_model/check_out_view_model.dart';
import '../widgets/custom_button.dart';
import 'order_summary.dart';

class CheckOutScreen extends StatefulWidget {
  final List<CartItemModel> selectedItems;
  const CheckOutScreen({super.key, required this.selectedItems});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  late  CheckOutViewModel checkOutViewModel;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkOutViewModel = CheckOutViewModel(widget.selectedItems);
  }

  @override
  void dispose() {
    checkOutViewModel.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final paymentMethods = [
      {'title': 'Stripe Payment', 'icon': Icons.credit_card},
      {'title': 'EasyPaisa', 'icon': Icons.account_balance_wallet},
      {'title': 'JazzCash', 'icon': Icons.account_balance},
      {'title': 'Cash on Delivery', 'icon': Icons.money}
    ];

    return ChangeNotifierProvider(
      create: (_) => checkOutViewModel,
      child: Consumer<CheckOutViewModel>(
        builder: (_, value, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'CheckOut',
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.green.shade500,
            ),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.w, top: 10.h),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Payment Methods',
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                    itemCount: paymentMethods.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Icon(paymentMethods[index]['icon'] as IconData),
                          title: Text(
                            paymentMethods[index]['title'].toString(),
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          trailing: Radio<int>(
                            value: index,
                            groupValue: value.selectedMethodIndex,
                            onChanged: (val) {
                              value.selectMethod(val!);
                            },
                          ),
                          onTap: () {
                            value.selectMethod(index);
                          },
                        ),
                      );
                    },
                  ),
                ),
                OrderSummary(
                  subTotal: checkOutViewModel.subTotal,
                  deliveryFee: checkOutViewModel.deliveryFee,
                  total: checkOutViewModel.total,
                ),

                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomButtons(
                    name: 'Place Order',
                    onPressed: () async {
                      if (checkOutViewModel.selectedMethodIndex == -1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please select a payment method')),
                        );
                        return;
                      }
                      bool success = await checkOutViewModel.placeOrder();
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Order placed successfully!')),
                        );
                        Navigator.pop(context); // or navigate as needed
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Order failed. Please try again.')),
                        );
                      }
                    },
                  )

                ),
                SizedBox(height: 20.h),
              ],
            ),
          );
        },
      ),
    );
  }

}

