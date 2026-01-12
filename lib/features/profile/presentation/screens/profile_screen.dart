import 'package:animal_world/core/constants/image_source.dart';
import 'package:animal_world/core/navigation/data/constants/bottom_navigation_ui_constants.dart';
import 'package:animal_world/core/services/storage_service.dart';
import 'package:animal_world/core/shared/widgets/gradient_button.dart';
import 'package:animal_world/core/shared/widgets/glass_card.dart';
import 'package:animal_world/core/shared/widgets/stat_card.dart';
import 'package:animal_world/core/shared/widgets/custom_popup.dart';
import 'package:animal_world/core/theme/app_border_radius.dart';
import 'package:animal_world/core/theme/app_colors.dart';
import 'package:animal_world/core/theme/app_fonts.dart';
import 'package:animal_world/core/theme/app_spacing.dart';
import 'package:animal_world/features/game/domain/usecases/get_animals.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final StorageService storageService;
  final GetAnimals getAnimals;

  const ProfileScreen({
    super.key,
    required this.storageService,
    required this.getAnimals,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _animalsViewed = 0;
  int _gamesPlayed = 0;
  int _bestScore = 0;
  int _totalAnimals = 0;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    final viewedIds = await widget.storageService.getViewedAnimalsIds();
    final gamesPlayed = await widget.storageService.getGamesPlayed();
    final bestScore = await widget.storageService.getBestScore();
    final animals = await widget.getAnimals();

    setState(() {
      _animalsViewed = viewedIds.length;
      _gamesPlayed = gamesPlayed;
      _bestScore = bestScore;
      _totalAnimals = animals.length;
      _progress = _totalAnimals > 0 ? viewedIds.length / _totalAnimals : 0.0;
    });
  }

  Future<void> _resetProgress() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => CustomPopup(
        title: 'Reset Progress',
        content: const Text(
          'Are you sure you want to reset all progress? This action cannot be undone.',
          style: AppFonts.bodyMedium,
          textAlign: TextAlign.center,
        ),
        primaryButton: GradientButton(
          text: 'Reset',
          onPressed: () => Navigator.of(context).pop(true),
        ),
        secondaryButton: GradientButton(
          text: 'Cancel',
          isSecondary: true,
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ),
    );

    if (confirmed == true) {
      await widget.storageService.resetProgress();
      await widget.storageService.clearGameState();
      await _loadStatistics();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Progress reset')));
      }
    }
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => CustomPopup(
        title: 'About',
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Animal World', style: AppFonts.headlineLarge),
            SizedBox(height: 8),
            Text('Version 1.0.0', style: AppFonts.bodyMedium),
            SizedBox(height: 16),
            Text(
              'Learn about animals and play the "Guess the Animal" mini-game!',
              style: AppFonts.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        primaryButton: GradientButton(
          text: 'Close',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  String _getUsername() {
    if (_animalsViewed == 0) {
      return 'Beginner';
    } else if (_animalsViewed < _totalAnimals / 3) {
      return 'Animal Lover';
    } else if (_animalsViewed < (_totalAnimals * 2) / 3) {
      return 'Nature Expert';
    } else if (_animalsViewed < _totalAnimals) {
      return 'Animal Expert';
    } else {
      return 'Zoology Master';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Profile'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: AppSpacing.md,
              right: AppSpacing.md,
              top: AppSpacing.md,
              bottom:
                  BottomNavigationUIConstants.barHeight +
                  AppSpacing.xxl +
                  AppSpacing.md,
            ),
            child: Column(
              children: [
                GlassCard(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.glowOrange,
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            ImageSource.lion,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.primaryOrange,
                                      AppColors.primaryOrangeLight,
                                    ],
                                  ),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 50,
                                  color: AppColors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: AppSpacing.md),
                      Text(
                        _getUsername(),
                        style: AppFonts.displaySmall.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSpacing.lg),
                StatCard(
                  icon: Icons.visibility,
                  label: 'Animals viewed',
                  value: '$_animalsViewed / $_totalAnimals',
                  iconColor: AppColors.primaryOrange,
                ),
                SizedBox(height: AppSpacing.md),
                StatCard(
                  icon: Icons.games,
                  label: 'Games played',
                  value: '$_gamesPlayed',
                  iconColor: AppColors.accentYellow,
                ),
                SizedBox(height: AppSpacing.md),
                StatCard(
                  icon: Icons.star,
                  label: 'Best score',
                  value: '$_bestScore',
                  iconColor: AppColors.accentCoral,
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
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Animal discovery progress',
                        style: AppFonts.headlineSmall.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: AppSpacing.md),
                      Container(
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppBorderRadius.pill,
                          ),
                          color: AppColors.greyLight,
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: _progress,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppBorderRadius.pill,
                              ),
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.gradientOrangeStart,
                                  AppColors.gradientOrangeEnd,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.glowOrange,
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: AppSpacing.sm),
                      Text(
                        '${(_progress * 100).toInt()}%',
                        style: AppFonts.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSpacing.lg),
                GradientButton(
                  text: 'Reset progress',
                  onPressed: _resetProgress,
                  isSecondary: true,
                ),
                SizedBox(height: AppSpacing.md),
                GradientButton(
                  text: 'About',
                  onPressed: _showAboutDialog,
                  isSecondary: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
