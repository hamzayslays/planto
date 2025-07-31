import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planto/resources/app_colors.dart';

class AppButtons extends StatelessWidget {
  final VoidCallback onPress;
  final Color? color;
  final String text;


   AppButtons({super.key, required this.onPress,  this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
         height: 28.h,
      width: 78.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.buttonColor,
          width: 1.w
        )
      ),
      child: Center(child: Text(text, style: TextStyle(fontSize: 14.sp,
      color: AppColors.textColor
      ) )),

    );
  }
}
