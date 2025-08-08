import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../view_model/check_out_view_model.dart';

class OrderSummary extends StatelessWidget {
  final double subTotal;
  final double deliveryFee;
  final double total;

  const OrderSummary({
    Key? key,
    required this.subTotal,
    required this.deliveryFee,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CheckOutViewModel>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            _summaryRow('Subtotal', viewModel.subTotal),
            SizedBox(height: 5.h),
            _summaryRow('Delivery Fee', viewModel.deliveryFee),
            Divider(),
            _summaryRow('Total', viewModel.total, isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String title, double value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          'PKR ${value.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
