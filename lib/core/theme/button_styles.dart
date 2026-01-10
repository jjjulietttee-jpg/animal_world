import 'package:animal_world/core/theme/app_border_radius.dart';
import 'package:animal_world/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

ButtonStyle primaryButtonStyle({double radius = AppBorderRadius.md}) {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color?>(
      (states) => states.contains(WidgetState.disabled)
          ? AppColors.primaryOrange.withOpacity(0.5)
          : AppColors.primaryOrange,
    ),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
    ),
    overlayColor: WidgetStateProperty.resolveWith<Color?>(
      (states) => states.contains(WidgetState.pressed)
          ? AppColors.white.withOpacity(0.26)
          : AppColors.white.withOpacity(0.06),
    ),
    elevation: WidgetStateProperty.resolveWith<double>(
      (states) => states.contains(WidgetState.pressed) ? 6.0 : 0.0,
    ),
    shadowColor: WidgetStateProperty.all<Color>(AppColors.shadowLight),
  );
}
