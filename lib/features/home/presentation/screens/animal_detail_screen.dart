import 'package:animal_world/core/services/storage_service.dart';
import 'package:animal_world/core/theme/app_border_radius.dart';
import 'package:animal_world/core/theme/app_colors.dart';
import 'package:animal_world/core/theme/app_fonts.dart';
import 'package:animal_world/core/theme/app_spacing.dart';
import 'package:animal_world/features/game/domain/entities/animal.dart';
import 'package:flutter/material.dart';

class AnimalDetailScreen extends StatefulWidget {
  final Animal animal;
  final StorageService? storageService;

  const AnimalDetailScreen({
    super.key,
    required this.animal,
    this.storageService,
  });

  @override
  State<AnimalDetailScreen> createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.storageService != null) {
      widget.storageService!.incrementAnimalsViewed(widget.animal.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final animal = widget.animal;
    
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.gradientStart,
            AppColors.gradientEnd,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(animal.name),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: 'animal_${animal.id}',
                  child: Container(
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppBorderRadius.xl),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.glowOrange,
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                        BoxShadow(
                          color: AppColors.shadowMedium,
                          blurRadius: 20,
                          spreadRadius: 0,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppBorderRadius.xl),
                      child: Image.asset(
                        animal.imagePath,
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
                  ),
                ),
                SizedBox(height: AppSpacing.lg),
                Container(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        animal.name,
                        style: AppFonts.displayMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: AppSpacing.md),
                      Text(
                        animal.description,
                        style: AppFonts.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.6,
                        ),
                      ),
                    ],
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
