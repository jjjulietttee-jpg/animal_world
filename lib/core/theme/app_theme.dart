import 'package:animal_world/core/theme/app_border_radius.dart';
import 'package:animal_world/core/theme/app_colors.dart';
import 'package:animal_world/core/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBg,
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryOrange,
      brightness: Brightness.light,
      primary: AppColors.primaryOrange,
      secondary: AppColors.primaryOrangeLight,
      surface: AppColors.cardBg,
      error: AppColors.errorRed,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
      titleTextStyle: AppFonts.headlineLarge.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.cardBg,
      elevation: 0,
      shadowColor: AppColors.shadowLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.greyMedium,
      thickness: 1,
    ),
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.scaffoldBg,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.scaffoldBg,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
  );
}
