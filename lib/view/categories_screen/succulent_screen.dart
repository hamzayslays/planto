import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planto/utils/routes/routes_name.dart';
import 'package:planto/view_model/plants_view_model.dart';
import 'package:provider/provider.dart';
import '../../resources/app_colors.dart';
import '../../data/reponse/status.dart';
import '../../resources/app_Url.dart';

class SucculentScreen extends StatefulWidget {
  const SucculentScreen({super.key});

  @override
  State<SucculentScreen> createState() => _SucculentScreenState();
}

class _SucculentScreenState extends State<SucculentScreen> {
  late PlantsViewModel plantsViewModel;

  @override
  void initState() {
    super.initState();
    plantsViewModel = PlantsViewModel();
    plantsViewModel.getAllPlants();
  }

  @override
  void dispose() {
    plantsViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: plantsViewModel,
      child: Consumer<PlantsViewModel>(
        builder: (context, value, child) {
          switch (value.getPlants.status) {
            case Status.LOADING:
              return Center(child: CircularProgressIndicator());

            case Status.ERROR:
              return Center(child: Text('Something went wrong'));

            case Status.COMPLETED:
              var allPlants = value.getPlants.data?.data ?? [];
              final succulentPlants = allPlants
                  .where((plant) =>
              plant.category?.toLowerCase() == 'succulent')
                  .toList();

              return Scaffold(
                appBar: AppBar(
                  title:    Text(
                    'Succulent',
                    style: GoogleFonts.notoSans(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                ),
                body: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 24.h),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: succulentPlants.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 24.h,
                            crossAxisSpacing: 12.w,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (context, index) {
                            final plant = succulentPlants[index];

                            String imageUrl = '';
                            if (plant.image != null &&
                                plant.image!.startsWith('http')) {
                              imageUrl = plant.image!;
                            } else if (plant.image != null) {
                              imageUrl = AppUrl.baseUrl +
                                  (plant.image!.startsWith('/')
                                      ? plant.image!
                                      : '/' + plant.image!);
                            }

                            return InkWell(
                              onTap: () {
Navigator.pushNamed(context, RoutesName.order,
arguments: plant.sId.toString()
);                              },
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
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            plant.plantname ?? 'Unknown',
                                            style: GoogleFonts.notoSans(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.buttonColor,
                                            ),
                                          ),
                                          SizedBox(height: 10.h),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Rs. ${plant.price ?? 0}/-",
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
                                        ],
                                      ),
                                    ),
                                  ),

                                  /// ✅ IMAGE OVERLAP
                                  Positioned(
                                    right: 30,
                                    top: -40,
                                    child: imageUrl.isNotEmpty
                                        ? Image.network(
                                      imageUrl,
                                      height: 120.h,
                                      width: 120.w,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                          Icon(
                                            Icons.broken_image,
                                            size: 50.sp,
                                            color: Colors.grey,
                                          ),
                                    )
                                        : Icon(
                                      Icons.image_not_supported,
                                      size: 50.sp,
                                      color: Colors.grey,
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
              return Center(child: Text('Undefined state'));
          }
        },
      ),
    );
  }
}
