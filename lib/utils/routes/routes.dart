import 'package:flutter/material.dart';
import 'package:planto/utils/routes/routes_name.dart';

import '../../view/splash_screen.dart';


class Routes{

  static Route<dynamic>  generateRoute(RouteSettings settings){
    switch (settings.name){

      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => SplashScreen());




      default:
        return MaterialPageRoute(builder: (_){

          return Scaffold(
            body: Center(child: Text('No routes defined   '),),
          );

        });
    }
  }
}