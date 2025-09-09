import 'package:flutter/cupertino.dart';
import 'package:openlibrary_book_explorer/Presentation/Views/ForgetPasswordScreen.dart';
import 'package:openlibrary_book_explorer/Presentation/Views/LogInScreen.dart';
import 'package:openlibrary_book_explorer/Presentation/Views/SignUpScreen.dart';
import '../Presentation/Views/HomeScreen.dart';
import '../Presentation/Views/OnBoardingScreen.dart';
import '../Presentation/Views/SplashScreen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onBoarding = '/onBoarding';
  static const String login = 'login';
  static const String signUp = '/signUp';
  static const String forgetPassword = 'forgetPassword';
  static const String home = '/home';


  static Map<String, WidgetBuilder> routes = {
    splash: (context) => SplashScreen(),
    onBoarding: (context) => OnBoardingScreen(),
    login: (context) => LogInScreen(),
    signUp: (context) => SignUpScreen(),
    forgetPassword : (context) => ForgetPasswordScreen(),
    home: (context) => HomeScreen(),
  };
}
