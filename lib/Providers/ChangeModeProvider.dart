import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Presentation/Elements/CustomContainer.dart';
import '../Configuration/Colors.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isNightMode = false;

  bool get isNightMode => _isNightMode;

  /// Background Color
  LinearGradient get backgroundColor =>
      _isNightMode
          ? AppColors.nightModeBackgroundColor
          : AppColors.dayModeBackgroundColor;

  /// Text Primary Color
  Color get primaryTextColor =>
      _isNightMode
          ? AppColors.nightModePrimaryTextColor
          : AppColors.dayModePrimaryTextColor;

  /// Text Secondary Color
  Color get secondaryTextColor =>
      _isNightMode
          ? AppColors.nightModeSecondaryTextColor
          : AppColors.dayModeSecondaryTextColor;

  /// AppBar Background Color
  Color get appBarBackgroundColor =>
      _isNightMode ?
      AppColors.nightModeAppBarBackgroundColor :
      AppColors.dayModeAppBarBackgroundColor;

  /// Button Background Color
  Color get buttonBackgroundColor =>
      _isNightMode
          ? AppColors.nightButtonBackground
          : AppColors.dayButtonBackground;

  /// Button Text Color
  Color get buttonTextColor =>
      _isNightMode
          ? AppColors.nightButtonText
          : AppColors.dayButtonText;

  MyIconContainer get bookIcon =>
      _isNightMode ? MyIconContainer(
        iconAsset: "assets/icons/darkModeBook.png",) : MyIconContainer(
        iconAsset: "assets/icons/dayModeBook.png",);

  void toggleTheme() {
    _isNightMode = !_isNightMode;
    notifyListeners();
  }

  void setTheme(bool isNight) {
    _isNightMode = isNight;
    notifyListeners();
  }
}
