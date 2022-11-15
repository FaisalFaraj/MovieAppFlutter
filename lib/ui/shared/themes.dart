import 'package:flutter/material.dart';

import '../../core/constant/app_colors.dart';

class AppThemes {
  static ThemeData darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.dark,
      primary: AppColors.app_color_primary_dark,
      onPrimary: AppColors.app_color_on_primary_dark,
      secondary: AppColors.app_color_secondary_dark,
      onSecondary: AppColors.app_color_on_secondary_dark,
      primaryContainer: Colors.black54,
      onPrimaryContainer: Colors.white,
    ),
  );

  static ThemeData lightTheme = ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        brightness: Brightness.light,
        primary: AppColors.app_color_primary_light,
        onPrimary: AppColors.app_color_on_primary_light,
        secondary: AppColors.app_color_secondary_light,
        onSecondary: AppColors.app_color_on_secondary_light,
        primaryContainer: Colors.black87,
        onPrimaryContainer: Colors.white,
      ));
}
