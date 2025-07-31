import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planto/resources/app_colors.dart';
import 'package:provider/provider.dart';

import '../view_model/home_screen_view_model.dart';
import 'order_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, provider, child) {
        return Scaffold(
          drawer: Drawer(child: Center(child: Text("Drawer Content"))),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 25.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('asset/logo.png', height: 55.h),
                          Padding(
                            padding: EdgeInsets.only(top: 28.h, left: 8.w),
                            child: Text(
                              'Planto.',
                              style: GoogleFonts.bowlbyOne(fontSize: 22),
                            ),
                          ),
                        ],
                      ),
                      Builder(
                        builder:
                            (context) => InkWell(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: Icon(
                                Icons.menu,
                                size: 35,
                                color: Colors.green.shade500,
                              ),
                            ),
                      ),
                    ],
                  ),
                ),

                // Carousel Slider
                Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 134.h,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                    ),
                    items: List.generate(provider.imagePaths.length, (index) {
                      final path = provider.imagePaths[index];
                      final title = provider.textTitle[index];
                      final subTitle = provider.subTitle[index];

                      return Builder(
                        builder: (BuildContext context) {
                          return Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(20.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 16.h,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: GoogleFonts.notoSans(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 50.w,
                                        top: 4.h,
                                      ),
                                      child: Text(
                                        subTitle,
                                        style: GoogleFonts.lato(
                                          fontSize: 14.sp,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Positioned(
                                right: 0,
                                bottom: 32.h,
                                top: -20,
                                child: Image.asset(path, height: 150.h),
                              ),
                            ],
                          );
                        },
                      );
                    }),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(right: 228.w, bottom: 18.h),
                  child: Text(
                    'Categories',
                    style: GoogleFonts.notoSans(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        provider.categories.map((category) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Container(
                              height: 80.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(18.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    category.icon,
                                    size: 36.sp,
                                    color: Colors.green.shade700,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    category.name,
                                    style: GoogleFonts.notoSans(
                                      fontSize: 12.sp,
                                      color: AppColors.buttonColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(right: 208.w, top: 20.h),
                  child: Text(
                    'Popular items',
                    style: GoogleFonts.notoSans(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OrderScreen() ));

                    },
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: provider.gridImagePaths.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 24.h,
                        crossAxisSpacing: 12.w,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        final img = provider.gridImagePaths[index];
                        final name = provider.gridNames[index];
                        final price = provider.gridPrice[index];

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
                                      name,
                                      style: GoogleFonts.notoSans(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.buttonColor,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 8.w,
                                        top: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Rs. $price/-",
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
                              left: 38,
                              top: -45,
                              child: Image.asset(
                                img,
                                height: 100.h,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
