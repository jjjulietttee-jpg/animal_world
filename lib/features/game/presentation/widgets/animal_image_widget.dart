import 'package:animal_world/core/theme/app_border_radius.dart';
import 'package:animal_world/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AnimalImageWidget extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;

  const AnimalImageWidget({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 300,
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppBorderRadius.xl),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppBorderRadius.xl),
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.greyLight,
              child: const Center(
                child: Icon(
                  Icons.image_not_supported,
                  size: 64,
                  color: AppColors.greyDark,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
