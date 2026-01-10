import 'package:animal_world/core/theme/app_border_radius.dart';
import 'package:animal_world/core/theme/app_colors.dart';
import 'package:animal_world/core/theme/app_fonts.dart';
import 'package:animal_world/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class AnswerButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isSelected;
  final bool isCorrect;
  final bool isWrong;

  const AnswerButtonWidget({
    super.key,
    required this.text,
    this.onPressed,
    this.isSelected = false,
    this.isCorrect = false,
    this.isWrong = false,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = AppColors.cardBg;
    Color textColor = AppColors.textPrimary;
    Color? glowColor;
    Color borderColor = AppColors.greyMedium;

    if (isCorrect) {
      backgroundColor = AppColors.successGreenLight.withOpacity(0.2);
      borderColor = AppColors.successGreen;
      textColor = AppColors.successGreen;
      glowColor = AppColors.successGreen.withOpacity(0.4);
    } else if (isWrong) {
      backgroundColor = AppColors.errorRedLight.withOpacity(0.2);
      borderColor = AppColors.errorRed;
      textColor = AppColors.errorRed;
      glowColor = AppColors.errorRed.withOpacity(0.4);
    } else if (isSelected) {
      backgroundColor = AppColors.primaryOrangeSoft;
      borderColor = AppColors.primaryOrange;
      textColor = AppColors.primaryOrange;
      glowColor = AppColors.glowOrange;
    }

    return Container(
      width: double.infinity,
      height: 64,
      margin: EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: glowColor != null
            ? [
                BoxShadow(
                  color: glowColor,
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ]
            : [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 8,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text(
              text,
              style: AppFonts.headlineMedium.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
