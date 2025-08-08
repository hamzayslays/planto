import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planto/utils/routes/routes.dart';
import 'package:planto/utils/routes/routes_name.dart';
import 'package:planto/view_model/cart_view_model.dart';
import 'package:planto/view_model/check_out_view_model.dart';
import 'package:planto/view_model/delete_cart_view_model.dart';
import 'package:planto/view_model/fav_view_model.dart';
import 'package:planto/view_model/get_cart_view_model.dart';
import 'package:planto/view_model/home_screen_view_model.dart';
import 'package:planto/view_model/onboarding_view_model.dart';
import 'package:planto/view_model/order_view_model.dart';
import 'package:planto/view_model/payment_methods/stripe_view_model.dart';
import 'package:planto/view_model/signup_view_model.dart';
import 'package:planto/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'view/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => OrderViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => GetCartViewModel()),
        ChangeNotifierProvider(create: (_) => DeleteCartViewModel()),
        ChangeNotifierProvider(create: (_) => FavoriteViewModel()),
        ChangeNotifierProvider(create: (_) => StripePaymentViewModel()),
        ChangeNotifierProvider(create: (_) =>  CheckOutViewModel([])),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child){
        return  MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RoutesName.splash,
          onGenerateRoute: Routes.generateRoute,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: SplashScreen(),
        );
      }
    );
  }
}

