import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planto/resources/app_colors.dart';
import 'package:planto/utils/routes/routes_name.dart';
import 'package:planto/view_model/order_view_model.dart';
import 'package:provider/provider.dart';
import '../data/reponse/status.dart';
import '../view_model/cart_view_model.dart';

class OrderScreen extends StatefulWidget {
  final String plantId;
  OrderScreen({super.key, required this.plantId});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  OrderViewModel orderViewModel = OrderViewModel();

  @override
  void initState() {
    super.initState();
    orderViewModel.getPlantbyId(widget.plantId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrderViewModel>(
      create: (_) => orderViewModel,
      child: Consumer<OrderViewModel>(
        builder: (context, value, child) {
          switch (value.getPlantById.status) {
            case Status.LOADING:
              return Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Text('Something went wrong');
            case Status.COMPLETED:
              return SafeArea(
                child: Scaffold(
                  appBar: AppBar(),
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Container(
                            height: 350,
                            width: 350,
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Image.network(
                              value.getPlantById.data!.data!.image.toString(),
                              height: 200,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 12.h,
                            right: 100.w,
                            bottom: 4.h,
                          ),
                          child: Text(
                            value.getPlantById.data!.data!.plantname.toString(),
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.bold,
                              color: AppColors.buttonColor,
                              fontSize: 23.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Rs. ${value.getPlantById.data!.data!.price}/-",
                            style: GoogleFonts.notoSans(fontSize: 18.sp),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
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
                            value.getPlantById.data!.data!.description
                                .toString(),
                            style: GoogleFonts.notoSans(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(bottom: 28.h),
                          child: Consumer<CartViewModel>(
                            builder: (context, cartViewModel, child) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Provider.of<OrderViewModel>(
                                            context,
                                            listen: false,
                                          ).decrement();
                                        },
                                        child: Container(
                                          height: 40.h,
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                  0.05,
                                                ),
                                                blurRadius: 5.r,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.black,
                                            size: 20.sp,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6.w,
                                        ),
                                        child: Text(
                                          Provider.of<OrderViewModel>(
                                            context,
                                          ).quantity.toString(),
                                          style: TextStyle(
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Provider.of<OrderViewModel>(
                                            context,
                                            listen: false,
                                          ).increment();
                                        },
                                        child: Container(
                                          height: 40.h,
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                  0.05,
                                                ),
                                                blurRadius: 5.r,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.green,
                                            size: 20.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap:
                                        () async {
                                      final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
                                      final orderViewModel = Provider.of<OrderViewModel>(context, listen: false);
                                      final plant = value.getPlantById.data!.data!;

                                      await cartViewModel.addToCartApiHandler(
                                        context: context,
                                        plantId: plant.sId!,
                                        quantity: orderViewModel.quantity,
                                        price: plant.price?.toDouble() ?? 0.0,
                                        name: plant.plantname ?? '',
                                        imageUrl: plant.image ?? '',
                                      );

                                      Navigator.pushNamed(context, RoutesName.cart);
                                    },

                                    child: Container(
                                      height: 48.h,
                                      width: 200.w,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade50,
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.05,
                                            ),
                                            blurRadius: 5.r,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Add to cart',
                                          style: TextStyle(
                                            color: AppColors.buttonColor,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
              return Scaffold(body: Center(child: Text('Unexpected state')));
          }
        },
      ),
    );
  }
}
