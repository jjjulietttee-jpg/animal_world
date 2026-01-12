import 'package:animal_world/core/theme/app_colors.dart';
import 'package:animal_world/core/theme/app_fonts.dart';
import 'package:animal_world/core/theme/app_spacing.dart';
import 'package:animal_world/features/game/domain/entities/animal_category.dart';
import 'package:animal_world/features/animals_list/presentation/widgets/filter_chip_widget.dart';
import 'package:flutter/material.dart';

class FiltersSectionWidget extends StatelessWidget {
  final AnimalCategory? selectedCategory;
  final AnimalHabitat? selectedHabitat;
  final AnimalSize? selectedSize;
  final AnimalActivity? selectedActivity;
  final Function(AnimalCategory?) onCategoryChanged;
  final Function(AnimalHabitat?) onHabitatChanged;
  final Function(AnimalSize?) onSizeChanged;
  final Function(AnimalActivity?) onActivityChanged;
  final VoidCallback onClearFilters;

  const FiltersSectionWidget({
    super.key,
    required this.selectedCategory,
    required this.selectedHabitat,
    required this.selectedSize,
    required this.selectedActivity,
    required this.onCategoryChanged,
    required this.onHabitatChanged,
    required this.onSizeChanged,
    required this.onActivityChanged,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    final hasActiveFilters = selectedCategory != null ||
        selectedHabitat != null ||
        selectedSize != null ||
        selectedActivity != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Filters',
              style: AppFonts.headlineSmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            AnimatedOpacity(
              opacity: hasActiveFilters ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: IgnorePointer(
                ignoring: !hasActiveFilters,
                child: TextButton(
                  onPressed: hasActiveFilters ? onClearFilters : null,
                  child: Text(
                    'Clear',
                    style: AppFonts.bodyMedium.copyWith(
                      color: AppColors.primaryOrange,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.sm),
        _buildFilterRow<AnimalCategory>(
          'Category',
          [
            ('Wild Animals', AnimalCategory.wildAnimals),
            ('Farm Animals', AnimalCategory.farmAnimals),
            ('Pets', AnimalCategory.pets),
            ('Birds', AnimalCategory.birds),
            ('Sea Animals', AnimalCategory.seaAnimals),
            ('Reptiles', AnimalCategory.reptiles),
            ('Insects', AnimalCategory.insects),
          ],
          selectedCategory,
          (value) => onCategoryChanged(value),
        ),
        SizedBox(height: AppSpacing.sm),
        _buildFilterRow<AnimalHabitat>(
          'Habitat',
          [
            ('Land', AnimalHabitat.land),
            ('Water', AnimalHabitat.water),
            ('Air', AnimalHabitat.air),
          ],
          selectedHabitat,
          (value) => onHabitatChanged(value),
        ),
        SizedBox(height: AppSpacing.sm),
        _buildFilterRow<AnimalSize>(
          'Size',
          [
            ('Small', AnimalSize.small),
            ('Medium', AnimalSize.medium),
            ('Large', AnimalSize.large),
          ],
          selectedSize,
          (value) => onSizeChanged(value),
        ),
        SizedBox(height: AppSpacing.sm),
        _buildFilterRow<AnimalActivity>(
          'Activity',
          [
            ('Day', AnimalActivity.day),
            ('Night', AnimalActivity.night),
          ],
          selectedActivity,
          (value) => onActivityChanged(value),
        ),
      ],
    );
  }

  Widget _buildFilterRow<T>(
    String title,
    List<(String, T)> options,
    T? selected,
    Function(T?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.bodySmall.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: AppSpacing.xs),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            ...options.map((option) {
              final (label, value) = option;
              final isCurrentlySelected = selected == value;
              return FilterChipWidget(
                label: label,
                isSelected: isCurrentlySelected,
                onTap: () {
                  if (isCurrentlySelected) {
                    onChanged(null);
                  } else {
                    onChanged(value);
                  }
                },
              );
            }),
          ],
        ),
      ],
    );
  }
}
