import 'package:flutter/material.dart';
import 'package:planto/utils/routes/routes_name.dart';
import 'package:planto/view/auth/forgot_password.dart';
import 'package:planto/view/auth/login_screen.dart';
import 'package:planto/view/auth/otp_screen.dart';
import 'package:planto/view/auth/sign_up.dart';
import 'package:planto/view/cart_screen.dart';
import 'package:planto/view/categories_screen/indoor_screen.dart';
import 'package:planto/view/categories_screen/outdoor_screen.dart';
import 'package:planto/view/categories_screen/succulent_screen.dart';
import 'package:planto/view/home_screen.dart';
import 'package:planto/view/onboarding_screen.dart';
import 'package:planto/view/order_screen.dart';
import 'package:planto/view/auth/change_password.dart';
import '../../view/bottom_nav_bar.dart';
import '../../view/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (BuildContext context) => SplashScreen(),
        );

      case RoutesName.onboarding:
        return MaterialPageRoute(
          builder: (BuildContext context) => OnboardingScreen(),
        );

      case RoutesName.signup:
        return MaterialPageRoute(
          builder: (BuildContext context) => SignupScreen(),
        );

      case RoutesName.login:
        return MaterialPageRoute(
          builder: (BuildContext context) => Loginscreen(),
        );

      case RoutesName.forgot:
        return MaterialPageRoute(
          builder: (BuildContext context) => ForgotPassword(),
        );

      case RoutesName.otpScreen:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (BuildContext context) => OtpScreen(email: email),
        );

      case RoutesName.changePassword:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (BuildContext context) => ChangePassword(email: email),
        );

      case RoutesName.bottom:
        return MaterialPageRoute(
          builder: (BuildContext context) => BottomNavBar(),
        );

      case RoutesName.home:
        return MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(),
        );

      case RoutesName.indoor:
        return MaterialPageRoute(
          builder: (BuildContext context) => IndoorScreen(),
        );

      case RoutesName.outdoor:
        return MaterialPageRoute(
          builder: (BuildContext context) => OutdoorScreen(),
        );

      case RoutesName.succulent:
        return MaterialPageRoute(
          builder: (BuildContext context) => SucculentScreen(),
        );

      case RoutesName.order:
        final plantId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (BuildContext context) => OrderScreen(plantId: plantId),
        );

       case RoutesName.cart:
        return MaterialPageRoute(
          builder: (BuildContext context) => CartScreen()
        );

      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(body: Center(child: Text('No routes defined   ')));
          },
        );
    }
  }
}
