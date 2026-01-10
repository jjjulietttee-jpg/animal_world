import 'package:animal_world/core/theme/app_border_radius.dart';
import 'package:animal_world/core/theme/app_colors.dart';
import 'package:animal_world/core/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomPopup extends StatelessWidget {
  final String title;
  final Widget? content;
  final Widget? primaryButton;
  final Widget? secondaryButton;
  final IconData? icon;
  final double? maxWidth;
  final double? maxHeight;

  const CustomPopup({
    super.key,
    required this.title,
    this.content,
    this.primaryButton,
    this.secondaryButton,
    this.icon,
    this.maxWidth,
    this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? 400,
          maxHeight: maxHeight ?? screenSize.height * 0.6,
        ),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          border: Border.all(
            color: AppColors.greyMedium,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryOrangeSoft,
                    border: Border.all(
                      color: AppColors.primaryOrange,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.primaryOrange,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 24),
              ],
              Text(
                title,
                style: AppFonts.displayMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              if (content != null) ...[
                const SizedBox(height: 16),
                Flexible(
                  child: SingleChildScrollView(
                    child: content!,
                  ),
                ),
              ],
              if (primaryButton != null || secondaryButton != null) ...[
                const SizedBox(height: 32),
                if (primaryButton != null) ...[
                  primaryButton!,
                  if (secondaryButton != null) const SizedBox(height: 12),
                ],
                if (secondaryButton != null) secondaryButton!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

