import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planto/data/reponse/status.dart';
import 'package:planto/utils/routes/routes_name.dart';
import 'package:planto/view_model/plants_view_model.dart';
import 'package:provider/provider.dart';
import '../../resources/app_colors.dart';
import 'package:planto/resources/app_Url.dart';

class OutdoorScreen extends StatefulWidget {
  const OutdoorScreen({Key? key}) : super(key: key);

  @override
  State<OutdoorScreen> createState() => _OutdoorScreenState();
}

class _OutdoorScreenState extends State<OutdoorScreen> {
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
          var allPlants = value.getPlants.data?.data ?? [];

          final outdoorPlants = allPlants
              .where(
                (plant) =>
            (plant.category ?? '').toLowerCase() == 'outdoor',
          )
              .toList();

          switch (value.getPlants.status) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());

            case Status.ERROR:
              return Center(
                child: Text(
                  'Something went wrong',
                  style: GoogleFonts.notoSans(fontSize: 16.sp),
                ),
              );

            case Status.COMPLETED:
              if (outdoorPlants.isEmpty) {
                return Center(
                  child: Text(
                    'No outdoor plants found.',
                    style: GoogleFonts.notoSans(fontSize: 18.sp),
                  ),
                );
              }
              return Scaffold(
                appBar: AppBar(
                  title:    Text(
                    'Outdoor Plants',

                    style: GoogleFonts.notoSans(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),

                  ),
                  centerTitle: true,
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: outdoorPlants.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 24.h,
                              crossAxisSpacing: 12.w,
                              childAspectRatio: 0.75,
                            ),
                            itemBuilder: (context, index) {
                              final plant = outdoorPlants[index];
                              String imageUrl = '';

                              if (plant.image != null &&
                                  plant.image!.startsWith('http')) {
                                imageUrl = plant.image!;
                              } else {
                                if (plant.image != null) {
                                  imageUrl = AppUrl.baseUrl +
                                      (plant.image!.startsWith('/')
                                          ? plant.image!
                                          : '/' + plant.image!);
                                } else {
                                  imageUrl = '';
                                }
                              }

                              return InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, RoutesName.order,
                                  arguments: plant.sId.toString()
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
                                            offset: const Offset(0, 4),
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
                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                                    // Positioned image same as Indoor
                                    Positioned(
                                      right: 20,
                                      top: -40,
                                      child: imageUrl.isNotEmpty
                                          ? Image.network(
                                        imageUrl,
                                        height: 120.h,
                                        width: 120.w,
                                        fit: BoxFit.contain,
                                        errorBuilder: (
                                            context,
                                            error,
                                            stackTrace,
                                            ) {
                                          return Icon(
                                            Icons.broken_image,
                                            size: 50.sp,
                                            color: Colors.grey,
                                          );
                                        },
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
                ),
              );

            default:
              return const Center(child: Text('Undefined state'));
          }
        },
      ),
    );
  }
}
