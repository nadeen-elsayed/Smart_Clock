import 'package:flutter/material.dart';
import 'package:modernlogintute/config/router/router_constants.dart';
import 'package:modernlogintute/signin_screen.dart';
import 'package:modernlogintute/view/screens/heart_rate.dart';
import 'package:modernlogintute/view/screens/home/home_screen.dart';
import 'package:modernlogintute/view/screens/main_screen.dart';
import 'package:modernlogintute/view/screens/search/search_screen.dart';
import 'package:modernlogintute/view/screens/settings/setting_screen.dart';
import 'package:modernlogintute/view/screens/splash/splash_screen.dart';

class AppRouter {

  final List screens = [
    const HomeScreen(),
    const SearchScreen(),
    const HeartRate(),
    const SettingScreen(),
    const SignInScreen(),
  ];

  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case signinRoute:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case searchRoute:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case heartRoute:
        return MaterialPageRoute(builder: (_) => const HeartRate());
      case settingRoute:
        return MaterialPageRoute(builder: (_) => const SettingScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
