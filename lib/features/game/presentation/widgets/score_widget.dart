import 'package:animal_world/core/theme/app_border_radius.dart';
import 'package:animal_world/core/theme/app_colors.dart';
import 'package:animal_world/core/theme/app_fonts.dart';
import 'package:animal_world/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  final int score;

  const ScoreWidget({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.gradientOrangeStart,
            AppColors.gradientOrangeEnd,
          ],
        ),
        borderRadius: BorderRadius.circular(AppBorderRadius.pill),
        boxShadow: [
          BoxShadow(
            color: AppColors.glowOrange,
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            color: AppColors.white,
            size: 24,
          ),
          SizedBox(width: AppSpacing.sm),
          Text(
            '$score',
            style: AppFonts.displaySmall.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
