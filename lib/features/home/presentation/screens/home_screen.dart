import 'package:animal_world/core/constants/home_constants.dart';
import 'package:animal_world/core/navigation/data/constants/bottom_navigation_ui_constants.dart';
import 'package:animal_world/core/navigation/data/constants/navigation_constants.dart';
import 'package:animal_world/core/shared/widgets/gradient_button.dart';
import 'package:animal_world/core/theme/app_colors.dart';
import 'package:animal_world/core/theme/app_fonts.dart';
import 'package:animal_world/core/theme/app_spacing.dart';
import 'package:animal_world/features/game/domain/entities/animal.dart';
import 'package:animal_world/features/game/domain/usecases/get_animals.dart';
import 'package:animal_world/features/home/presentation/widgets/animal_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  final GetAnimals getAnimals;

  const HomeScreen({super.key, required this.getAnimals});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<List<Animal>> _animalsFuture;

  @override
  void initState() {
    super.initState();
    _animalsFuture = widget.getAnimals();
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
          title: const Text('Animal World'),
        ),
        body: FutureBuilder<List<Animal>>(
          future: _animalsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Ошибка загрузки: ${snapshot.error}',
                  style: AppFonts.bodyLarge,
                ),
              );
            }

            final animals = snapshot.data ?? [];

            return SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(AppSpacing.md),
                    child: GradientButton(
                      text: '🎮 Начать игру "Угадай животное"',
                      onPressed: () {
                        context.go(NavigationConstants.game);
                      },
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.only(
                        left: AppSpacing.md,
                        right: AppSpacing.md,
                        top: AppSpacing.md,
                        bottom: BottomNavigationUIConstants.barHeight + AppSpacing.xxl + AppSpacing.md,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: HomeConstants.gridCrossAxisCount,
                            crossAxisSpacing: HomeConstants.gridCrossAxisSpacing,
                            mainAxisSpacing: HomeConstants.gridMainAxisSpacing,
                            childAspectRatio: HomeConstants.animalCardAspectRatio,
                          ),
                      itemCount: animals.length,
                      itemBuilder: (context, index) {
                        final animal = animals[index];
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
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
