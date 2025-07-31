import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planto/resources/app_colors.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Orders'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(height: 350, width: 350, color: Colors.grey),
            Padding(
              padding: EdgeInsets.only(right: 202.w, top: 10.h, bottom: 6.h),
              child: Text(
                'Farm Fresh',
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.bold,
                  color: AppColors.buttonColor,
                  fontSize: 22.sp,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  text: "\$10.00    ",
                  style: GoogleFonts.notoSans(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.buttonColor,
                  ),
                  children: [
                    TextSpan(
                      text: 'Discount 5%',
                      style: GoogleFonts.notoSans(
                        color: Colors.grey,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Description',
                  style: GoogleFonts.notoSans(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.buttonColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
                style: GoogleFonts.notoSans(color: Colors.grey.shade700),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 45.h,
                        width: 45.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5.r,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(Icons.remove, color: Colors.black, size: 20.sp),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 6.w, right: 6.w),
                        child: Text(
                          '1',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                      ),

                      Container(
                        height: 45.h,
                        width: 45.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5.r,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(Icons.add, color: Colors.green, size: 20.sp),
                      ),
                    ],
                  ),

                  Container(
                    height: 48.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5.r,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: AppColors.buttonColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
