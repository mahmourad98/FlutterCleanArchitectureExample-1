import 'package:flutter/material.dart';
import 'package:untitled05/config/app_colors.dart';
import 'package:untitled05/config/app_text_styles.dart';

class AppTheme {
  static const bool isDarkTheme = false;
  /////////////////////////
  static final ThemeData appThemeLight = ThemeData(
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.lightPrimary,
    primaryColorDark: AppColors.darkPrimary,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white1,
    disabledColor: AppColors.grey1,
    hintColor: AppColors.grey2,
    splashColor: isDarkTheme ? AppColors.darkPrimary : AppColors.lightPrimary,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.transparent,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        fontSize: FontSizeManager.s20,
        fontWeight: FontWeightManager.medium,
        color: AppColors.white1,
      ),
    ),
  );
  /////////////////////////
  static final ThemeData appThemeDark = ThemeData(
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.lightPrimary,
    primaryColorDark: AppColors.darkPrimary,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.grey5,
    disabledColor: AppColors.grey1,
    hintColor: AppColors.grey2,
    splashColor: isDarkTheme ? AppColors.darkPrimary : AppColors.lightPrimary,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.transparent,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        fontSize: FontSizeManager.s20,
        fontWeight: FontWeightManager.medium,
        color: AppColors.white1,
      ),
    ),
  );
}