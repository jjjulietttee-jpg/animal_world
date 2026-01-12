import 'package:animal_world/core/navigation/data/constants/bottom_navigation_ui_constants.dart';
import 'package:animal_world/core/navigation/data/constants/navigation_constants.dart';
import 'package:animal_world/core/theme/app_colors.dart';
import 'package:animal_world/core/theme/app_fonts.dart';
import 'package:animal_world/core/theme/app_spacing.dart';
import 'package:animal_world/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:animal_world/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:animal_world/features/favorites/presentation/bloc/favorites_state.dart';
import 'package:animal_world/features/home/presentation/widgets/animal_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesBloc>().add(const LoadFavorites());
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
          title: const Text('Favorites'),
        ),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is FavoritesError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: AppFonts.bodyLarge,
                ),
              );
            }

            if (state is FavoritesLoaded) {
              if (state.animals.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 64,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(height: AppSpacing.md),
                      Text(
                        'No favorite animals',
                        style: AppFonts.headlineSmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: AppSpacing.sm),
                      Text(
                        'Add animals to favorites to see them here',
                        style: AppFonts.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              return SafeArea(
                child: GridView.builder(
                  padding: EdgeInsets.only(
                    left: AppSpacing.md,
                    right: AppSpacing.md,
                    top: AppSpacing.md,
                    bottom: BottomNavigationUIConstants.barHeight +
                        AppSpacing.xxl +
                        AppSpacing.md,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: state.animals.length,
                  itemBuilder: (context, index) {
                    final animal = state.animals[index];
                    return AnimalCardWidget(
                      animal: animal,
                      onTap: () {
                        context.push(
                          '${NavigationConstants.home}/animal/${animal.id}',
                          extra: animal,
                        );
                      },
                    );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
