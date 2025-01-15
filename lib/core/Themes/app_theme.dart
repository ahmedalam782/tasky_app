import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorManager.white,
    fontFamily: 'DMSans',
    primaryColor: ColorManager.primary,
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: ColorManager.white,
      elevation: 0,
      titleTextStyle: getBoldStyle(
        color: ColorManager.mainBlack,
        fontSize: FontSize.s16,
      ),
    ),
  );
}
