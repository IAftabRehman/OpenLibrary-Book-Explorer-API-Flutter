import 'package:flutter/cupertino.dart';
import 'package:openlibrary_book_explorer/Presentation/Views/AuthorDetails.dart';
import 'package:openlibrary_book_explorer/Presentation/Views/AuthorsScreen.dart';
import 'package:openlibrary_book_explorer/Presentation/Views/BookRead.dart';
import 'package:openlibrary_book_explorer/Presentation/Views/CategoriesScreen.dart';
import 'package:openlibrary_book_explorer/Presentation/Views/ContactMeScreen.dart';
import 'package:openlibrary_book_explorer/Presentation/Views/FavoriteScreen.dart';
import 'package:openlibrary_book_explorer/Presentation/Views/ForgetPasswordScreen.dart';
import 'package:openlibrary_book_explorer/Presentation/Views/HelpScreen.dart';
import 'package:openlibrary_book_explorer/Presentation/Views/IndividualCategory.dart';
import 'package:openlibrary_book_explorer/Presentation/Views/LogInScreen.dart';
import 'package:openlibrary_book_explorer/Presentation/Views/ProfileScreen.dart';
import 'package:openlibrary_book_explorer/Presentation/Views/SignUpScreen.dart';
import 'package:openlibrary_book_explorer/Presentation/Views/TrendingBook.dart';
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
  static const String categories = '/categories';
  static const String authors = '/authors';
  static const String profile = '/profile';
  static const String individualCategory = '/individualCategory';
  static const String authorDetails = '/authorDetails';
  static const String trendingBook = '/trendingBook';
  static const String bookRead = '/bookRead';
  static const String favorite = '/favorite';
  static const String help = '/help';
  static const String contact = '/contactMe';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => SplashScreen(),
    onBoarding: (context) => OnBoardingScreen(),
    login: (context) => LogInScreen(),
    signUp: (context) => SignUpScreen(),
    forgetPassword : (context) => ForgetPasswordScreen(),
    home: (context) => HomeScreen(),
    categories: (context) => CategoriesScreen(),
    authors: (context) => AuthorsScreen(),
    profile: (context) => ProfileScreen(),
    trendingBook: (context) => TrendingBook(),
    favorite: (context) => FavoriteScreen(),
    help: (context) => HelpScreen(),
    contact: (context) => ContactMeScreen()
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.individualCategory:
        final args = settings.arguments as Map<String, dynamic>;
        return CupertinoPageRoute(
          builder: (_) => IndividualCategory(
            authorDetails: args["name"],
            categoryLink: args["link"],
          ),
        );

      case AppRoutes.authorDetails:
        final args = settings.arguments as Map<String, dynamic>;
        final details = args["authorDetails"];
        return CupertinoPageRoute(
          builder: (_) => AuthorDetails(
            authorDetails: details ?? {}, // ✅ fallback
          ),
        );

      case AppRoutes.bookRead:
        final args = settings.arguments as Map<String, dynamic>;
        return CupertinoPageRoute(
          builder: (_) => BookRead(
            ocaid: args["ocaid"],
          ),
        );

      default:
        return null;
    }
  }

}
