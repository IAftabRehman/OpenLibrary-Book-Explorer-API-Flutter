import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const String keyOnBoarding = "onBoardingSeen";

  /// Save OnBoarding
  static Future<void> setOnBoardingSeen(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyOnBoarding, value);
  }

  /// Get OnBoarding
  static Future<bool> isOnBoardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyOnBoarding) ?? false;
  }
}
