import 'package:animal_world/core/theme/app_border_radius.dart';
import 'package:animal_world/core/theme/app_colors.dart';
import 'package:animal_world/core/theme/app_fonts.dart';
import 'package:animal_world/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final bool isSecondary;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
    this.height = 56,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    final button = Container(
      height: height,
      decoration: BoxDecoration(
        gradient: isSecondary
            ? null
            : const LinearGradient(
                colors: [
                  AppColors.gradientOrangeStart,
                  AppColors.gradientOrangeEnd,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        color: isSecondary ? AppColors.greyLight : null,
        borderRadius: BorderRadius.circular(AppBorderRadius.pill),
        boxShadow: onPressed != null
            ? [
                BoxShadow(
                  color: isSecondary
                      ? AppColors.shadowLight
                      : AppColors.glowOrange,
                  blurRadius: 16,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppBorderRadius.pill),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            alignment: Alignment.center,
            child: Text(
              text,
              style: AppFonts.headlineMedium.copyWith(
                color: isSecondary ? AppColors.textPrimary : AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );

    if (width != null) {
      return SizedBox(width: width, child: button);
    }

    return SizedBox(width: double.infinity, child: button);
  }
}

