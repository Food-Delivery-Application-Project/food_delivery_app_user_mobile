import 'package:flutter/material.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';

abstract class AppTheme {
  static final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    useMaterial3: true,
  );

  static final dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.darkBackground,
  );
}
