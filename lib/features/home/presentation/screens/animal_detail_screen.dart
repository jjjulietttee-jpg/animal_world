import 'package:animal_world/core/navigation/data/constants/bottom_navigation_ui_constants.dart';
import 'package:animal_world/core/services/storage_service.dart';
import 'package:animal_world/core/shared/widgets/glass_card.dart';
import 'package:animal_world/core/theme/app_border_radius.dart';
import 'package:animal_world/core/theme/app_colors.dart';
import 'package:animal_world/core/theme/app_fonts.dart';
import 'package:animal_world/core/theme/app_spacing.dart';
import 'package:animal_world/features/game/domain/entities/animal.dart';
import 'package:animal_world/features/game/domain/entities/animal_category.dart';
import 'package:animal_world/features/favorites/domain/usecases/toggle_favorite_animal.dart';
import 'package:animal_world/features/favorites/domain/usecases/is_favorite_animal.dart';
import 'package:flutter/material.dart';

class AnimalDetailScreen extends StatefulWidget {
  final Animal animal;
  final StorageService? storageService;
  final ToggleFavoriteAnimal? toggleFavoriteAnimal;
  final IsFavoriteAnimal? isFavoriteAnimal;

  const AnimalDetailScreen({
    super.key,
    required this.animal,
    this.storageService,
    this.toggleFavoriteAnimal,
    this.isFavoriteAnimal,
  });

  @override
  State<AnimalDetailScreen> createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    if (widget.storageService != null) {
      widget.storageService!.incrementAnimalsViewed(widget.animal.id);
    }
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    if (widget.isFavoriteAnimal != null) {
      final isFavorite = await widget.isFavoriteAnimal!.call(widget.animal.id);
      if (mounted) {
        setState(() {
          _isFavorite = isFavorite;
        });
      }
    }
  }

  Future<void> _toggleFavorite() async {
    if (widget.toggleFavoriteAnimal != null) {
      final newStatus = await widget.toggleFavoriteAnimal!.call(widget.animal.id);
      if (mounted) {
        setState(() {
          _isFavorite = newStatus;
        });
      }
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
          actions: [
            IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? AppColors.errorRed : AppColors.textPrimary,
              ),
              onPressed: _toggleFavorite,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: AppSpacing.md,
              right: AppSpacing.md,
              top: AppSpacing.md,
              bottom: BottomNavigationUIConstants.barHeight +
                  AppSpacing.xxl +
                  AppSpacing.md,
            ),
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
                GlassCard(
                  padding: EdgeInsets.all(AppSpacing.lg),
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
                SizedBox(height: AppSpacing.lg),
                GlassCard(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Facts',
                        style: AppFonts.headlineSmall.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: AppSpacing.md),
                      _buildFactRow('Habitat', _getHabitatName(animal.habitat)),
                      SizedBox(height: AppSpacing.sm),
                      _buildFactRow('Diet', animal.diet),
                      SizedBox(height: AppSpacing.sm),
                      _buildFactRow('Lifespan', animal.lifespan),
                      SizedBox(height: AppSpacing.sm),
                      _buildFactRow('Fun Fact', animal.funFact),
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

  Widget _buildFactRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: AppSpacing.xs),
        Text(
          value,
          style: AppFonts.bodyMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  String _getHabitatName(AnimalHabitat habitat) {
    switch (habitat) {
      case AnimalHabitat.land:
        return 'Land';
      case AnimalHabitat.water:
        return 'Water';
      case AnimalHabitat.air:
        return 'Air';
    }
  }
}
