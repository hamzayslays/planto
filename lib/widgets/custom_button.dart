import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtons extends StatelessWidget {
  final name;
  bool loading;
  final onPressed;
  CustomButtons({super.key, this.name, this.onPressed, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        child: Center(
          child:
          loading
              ? CircularProgressIndicator(
            strokeWidth: 3,
            color: Colors.white,
          )
              : Text(
            name,

            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        height: 48.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color:  Colors.green.shade500,
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
