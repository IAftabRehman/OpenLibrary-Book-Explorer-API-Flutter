import 'package:flutter/cupertino.dart';
import '../Presentation/Views/HomeScreen.dart';
import '../Presentation/Views/OnBoardingScreen.dart';
import '../Presentation/Views/SplashScreen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onBoarding = '/onBoarding';
  static const String home = '/home';


  static Map<String, WidgetBuilder> routes = {
    splash: (context) => SplashScreen(),
    onBoarding: (context) => OnBoardingScreen(),
    home: (context) => HomeScreen(),
  };
}
