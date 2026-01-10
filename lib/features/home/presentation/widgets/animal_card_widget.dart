import 'package:animal_world/core/theme/app_border_radius.dart';
import 'package:animal_world/core/theme/app_colors.dart';
import 'package:animal_world/core/theme/app_fonts.dart';
import 'package:animal_world/core/theme/app_spacing.dart';
import 'package:animal_world/features/game/domain/entities/animal.dart';
import 'package:flutter/material.dart';

class AnimalCardWidget extends StatelessWidget {
  final Animal animal;
  final VoidCallback onTap;

  const AnimalCardWidget({
    super.key,
    required this.animal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'animal_${animal.id}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.cardBg,
                  AppColors.cardBgSoft,
                ],
              ),
              borderRadius: BorderRadius.circular(AppBorderRadius.lg),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 16,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppBorderRadius.md),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowMedium,
                          blurRadius: 12,
                          spreadRadius: 0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppBorderRadius.md),
                      child: Image.asset(
                        animal.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.greyLight,
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 48,
                                color: AppColors.greyDark,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: Text(
                    animal.name,
                    style: AppFonts.headlineMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
