import 'package:flutter/material.dart';
import 'package:untitled05/config/app_colors.dart';

class AppTheme {
  static const bool isDarkTheme = false;
  static final ThemeData appThemeLight = ThemeData(
    primaryColor: AppColors.graspGreenColor,
    hintColor: AppColors.grey25Color,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.transparent,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        height: 1.3,
        fontSize: 22.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  static final ThemeData appThemeDark = ThemeData(
    primaryColor: AppColors.graspGreenColor,
    hintColor: AppColors.grey25Color,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.transparent,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        height: 1.3,
        fontSize: 22.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}