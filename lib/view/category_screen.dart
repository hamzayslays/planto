import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resources/app_colors.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;

   const CategoryScreen({super.key,
     required this.categoryName,

   });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 40),
              child: Text(
                categoryName , style: GoogleFonts.notoSans(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold
              ),),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 8,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 24.h,
                crossAxisSpacing: 12.w,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 16.w,
                          top: 80.h,
                          right: 16.w,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'name',
                              style: GoogleFonts.notoSans(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.buttonColor,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.w, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Rs. price/-",
                                    style: GoogleFonts.notoSans(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.buttonColor,
                                    ),
                                  ),
                                  Icon(
                                    Icons.shopping_bag_outlined,
                                    color: AppColors.buttonColor,
                                    size: 28.sp,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Overflowing image above the card
                    Positioned(
                      right: 45,
                      bottom: 150,
                      child: Icon(Icons.image_outlined, size: 100),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
