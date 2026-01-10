import 'package:animal_world/core/theme/app_border_radius.dart';
import 'package:animal_world/core/theme/app_colors.dart';
import 'package:animal_world/core/theme/app_fonts.dart';
import 'package:flutter/material.dart';
import '../../constants/game_constants.dart';
import '../../constants/menu_constants.dart';

class DialogButtonBuilder {
  DialogButtonBuilder._();

  static Widget buildPrimaryButton({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: MenuConstants.playButtonHeight,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.gradientOrangeStart,
            AppColors.gradientOrangeEnd,
          ],
        ),
        borderRadius: BorderRadius.circular(
          AppBorderRadius.lg,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.glowOrange,
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
        borderRadius: BorderRadius.circular(
          AppBorderRadius.lg,
        ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: AppColors.white,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: AppFonts.headlineLarge.copyWith(
                    color: AppColors.white,
                    fontSize: GameConstants.dialogButtonFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildSecondaryButton({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: MenuConstants.secondaryButtonHeight,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(
          AppBorderRadius.lg,
        ),
        border: Border.all(
          color: AppColors.primaryOrange.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
        borderRadius: BorderRadius.circular(
          AppBorderRadius.lg,
        ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: AppColors.primaryOrange,
                  size: MenuConstants.buttonIconSize,
                ),
                const SizedBox(width: MenuConstants.buttonIconSpacing),
                Text(
                  text,
                  style: AppFonts.headlineMedium.copyWith(
                    color: AppColors.primaryOrange,
                    fontSize: GameConstants.dialogButtonFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

