import 'package:animal_world/core/constants/home_constants.dart';
import 'package:animal_world/core/navigation/data/constants/bottom_navigation_ui_constants.dart';
import 'package:animal_world/core/navigation/data/constants/navigation_constants.dart';
import 'package:animal_world/core/shared/widgets/gradient_button.dart';
import 'package:animal_world/core/theme/app_colors.dart';
import 'package:animal_world/core/theme/app_fonts.dart';
import 'package:animal_world/core/theme/app_spacing.dart';
import 'package:animal_world/features/animals_list/presentation/bloc/animals_list_bloc.dart';
import 'package:animal_world/features/animals_list/presentation/bloc/animals_list_event.dart';
import 'package:animal_world/features/animals_list/presentation/bloc/animals_list_state.dart';
import 'package:animal_world/features/animals_list/presentation/widgets/filters_section_widget.dart';
import 'package:animal_world/features/animals_list/presentation/widgets/search_bar_widget.dart';
import 'package:animal_world/features/home/presentation/widgets/animal_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showFilters = false;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _filtersKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    context.read<AnimalsListBloc>().add(const LoadAnimals());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleFilters() {
    setState(() {
      _showFilters = !_showFilters;
    });
    if (_showFilters) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_filtersKey.currentContext != null) {
          Scrollable.ensureVisible(
            _filtersKey.currentContext!,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
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
          title: const Text('Animal World'),
          actions: [
            IconButton(
              icon: Icon(
                _showFilters ? Icons.filter_list : Icons.filter_list_outlined,
                color: _showFilters
                    ? AppColors.primaryOrange
                    : AppColors.textPrimary,
              ),
              onPressed: _toggleFilters,
            ),
          ],
        ),
        body: BlocBuilder<AnimalsListBloc, AnimalsListState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SafeArea(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        children: [
                          GradientButton(
                            text: '🎮 Play "Guess the Animal"',
                            onPressed: () {
                              context.go(NavigationConstants.game);
                            },
                          ),
                          SizedBox(height: AppSpacing.md),
                          SearchBarWidget(
                            query: state.searchQuery,
                            onChanged: (query) {
                              context.read<AnimalsListBloc>().add(SearchAnimals(query));
                            },
                          ),
                          if (_showFilters) ...[
                            SizedBox(height: AppSpacing.md),
                            FiltersSectionWidget(
                              key: _filtersKey,
                              selectedCategory: state.selectedCategory,
                              selectedHabitat: state.selectedHabitat,
                              selectedSize: state.selectedSize,
                              selectedActivity: state.selectedActivity,
                              onCategoryChanged: (category) {
                                context
                                    .read<AnimalsListBloc>()
                                    .add(FilterByCategory(category));
                              },
                              onHabitatChanged: (habitat) {
                                context
                                    .read<AnimalsListBloc>()
                                    .add(FilterByHabitat(habitat));
                              },
                              onSizeChanged: (size) {
                                context
                                    .read<AnimalsListBloc>()
                                    .add(FilterBySize(size));
                              },
                              onActivityChanged: (activity) {
                                context
                                    .read<AnimalsListBloc>()
                                    .add(FilterByActivity(activity));
                              },
                              onClearFilters: () {
                                context.read<AnimalsListBloc>().add(const ClearFilters());
                              },
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  if (state.filteredAnimals.isEmpty)
                    SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'No animals found',
                          style: AppFonts.bodyLarge.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: EdgeInsets.only(
                        left: AppSpacing.md,
                        right: AppSpacing.md,
                        top: AppSpacing.md,
                        bottom: BottomNavigationUIConstants.barHeight +
                            AppSpacing.xxl +
                            AppSpacing.md,
                      ),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: HomeConstants.gridCrossAxisCount,
                          crossAxisSpacing:
                              HomeConstants.gridCrossAxisSpacing,
                          mainAxisSpacing:
                              HomeConstants.gridMainAxisSpacing,
                          childAspectRatio:
                              HomeConstants.animalCardAspectRatio,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final animal = state.filteredAnimals[index];
                            final isDiscovered =
                                state.discoveredIds.contains(animal.id);
                            return AnimalCardWidget(
                              key: ValueKey(animal.id),
                              animal: animal,
                              isDiscovered: isDiscovered,
                              onTap: () {
                                context.push(
                                  '${NavigationConstants.home}/animal/${animal.id}',
                                  extra: animal,
                                );
                              },
                            );
                          },
                          childCount: state.filteredAnimals.length,
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: true,
                          addSemanticIndexes: false,
                        ),
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
