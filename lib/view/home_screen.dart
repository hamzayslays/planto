import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planto/resources/app_colors.dart';
import 'package:planto/utils/routes/routes_name.dart';
import 'package:planto/view/categories_screen/outdoor_screen.dart';
import 'package:planto/view_model/home_screen_view_model.dart';
import 'package:provider/provider.dart';
import '../data/reponse/status.dart';
import 'categories_screen/indoor_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    homeViewModel.getAllPlants();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => homeViewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, provider, child) {
          switch (provider.getPlants.status) {
            case Status.LOADING:
              return Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Text('Something went wrong');
            case Status.COMPLETED:
              return Scaffold(
                drawer: Drawer(child: Center(child: Text("Drawer Content"))),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      /// Logo + Menu
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          top: 25.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset('asset/logo.png', height: 55.h),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 28.h,
                                    left: 8.w,
                                  ),
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
                                    onTap:
                                        () => Scaffold.of(context).openDrawer(),
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

                      /// Carousel Slider
                      Padding(
                        padding: EdgeInsets.only(top: 16.h),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 122.h,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            enlargeCenterPage: true,
                            viewportFraction: 0.9,
                          ),
                          items: List.generate(provider.imagePaths.length, (
                            index,
                          ) {
                            final path = provider.imagePaths[index];
                            final title = provider.textTitle[index];
                            final subTitle = provider.subTitle[index];

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
                                  padding: EdgeInsets.only(
                                    left: 16.w,
                                    right: 90.w,
                                    top: 18.h,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        title,
                                        style: GoogleFonts.notoSans(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        subTitle,
                                        style: GoogleFonts.lato(
                                          fontSize: 14.sp,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: 200,
                                  right: 0.h,
                                  bottom: 20.h,
                                  top: -15.h,
                                  child: Image.asset(path, height: 150.h),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),

                      /// Categories
                      Padding(
                        padding: EdgeInsets.only(
                          right: 228.w,
                          bottom: 18.h,
                          top: 20.h,
                        ),
                        child: Text(
                          'Categories',
                          style: GoogleFonts.notoSans(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, RoutesName.indoor);
                              },
                              child: Container(
                                height: 80.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(18.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 6.r,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.spa,
                                      size: 36.sp,
                                      color: Colors.green.shade700,
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      'Indoor',
                                      style: GoogleFonts.notoSans(
                                        fontSize: 12.sp,
                                        color: AppColors.buttonColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.outdoor,
                                );
                              },
                              child: Container(
                                height: 80.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(18.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 6.r,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.park,
                                      size: 36.sp,
                                      color: Colors.green.shade700,
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      'Outdoor',
                                      style: GoogleFonts.notoSans(
                                        fontSize: 12.sp,
                                        color: AppColors.buttonColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.succulent,
                                );
                              },
                              child: Container(
                                height: 80.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(18.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 6.r,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.eco,
                                      size: 36.sp,
                                      color: Colors.green.shade700,
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      'Succulent',
                                      style: GoogleFonts.notoSans(
                                        fontSize: 12.sp,
                                        color: AppColors.buttonColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: provider.getPlants.data!.data!.length,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 24.h,
                                crossAxisSpacing: 12.w,
                                childAspectRatio: 0.85555,
                              ),
                          itemBuilder: (context, index) {
                            var plant = provider.getPlants.data!.data![index];
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.order,
                                  arguments: plant.sId.toString(),
                                );
                              },
                              child: Stack(
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
                                            plant.plantname.toString() ?? '',
                                            style: GoogleFonts.notoSans(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.buttonColor,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              right: 8.w,
                                              top: 10,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Rs. ${plant.price}/-",
                                                  style: GoogleFonts.notoSans(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.buttonColor,
                                                  ),
                                                  textAlign: TextAlign.left,
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
                                  Positioned(
                                    left: 10.w,
                                    top: -45,
                                    child: Image.network(
                                      plant.image.toString() ?? '',
                                      height: 118.h,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Icon(Icons.broken_image),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );

            default:
              return const Scaffold(
                body: Center(child: Text('Unexpected state')),
              );
          }
        },
      ),
    );
  }
}
