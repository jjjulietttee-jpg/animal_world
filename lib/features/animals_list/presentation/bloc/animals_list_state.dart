import 'package:equatable/equatable.dart';
import '../../../game/domain/entities/animal.dart';
import '../../../game/domain/entities/animal_category.dart';

class AnimalsListState extends Equatable {
  final List<Animal> allAnimals;
  final List<Animal> filteredAnimals;
  final String searchQuery;
  final AnimalCategory? selectedCategory;
  final AnimalHabitat? selectedHabitat;
  final AnimalSize? selectedSize;
  final AnimalActivity? selectedActivity;
  final Set<String> favoriteIds;
  final Set<String> discoveredIds;
  final bool isLoading;

  const AnimalsListState({
    required this.allAnimals,
    required this.filteredAnimals,
    required this.searchQuery,
    required this.selectedCategory,
    required this.selectedHabitat,
    required this.selectedSize,
    required this.selectedActivity,
    required this.favoriteIds,
    required this.discoveredIds,
    required this.isLoading,
  });

  factory AnimalsListState.initial() {
    return const AnimalsListState(
      allAnimals: [],
      filteredAnimals: [],
      searchQuery: '',
      selectedCategory: null,
      selectedHabitat: null,
      selectedSize: null,
      selectedActivity: null,
      favoriteIds: {},
      discoveredIds: {},
      isLoading: false,
    );
  }

  AnimalsListState copyWith({
    List<Animal>? allAnimals,
    List<Animal>? filteredAnimals,
    String? searchQuery,
    AnimalCategory? selectedCategory,
    AnimalHabitat? selectedHabitat,
    AnimalSize? selectedSize,
    AnimalActivity? selectedActivity,
    Set<String>? favoriteIds,
    Set<String>? discoveredIds,
    bool? isLoading,
    bool clearCategory = false,
    bool clearHabitat = false,
    bool clearSize = false,
    bool clearActivity = false,
  }) {
    return AnimalsListState(
      allAnimals: allAnimals ?? this.allAnimals,
      filteredAnimals: filteredAnimals ?? this.filteredAnimals,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: clearCategory
          ? null
          : (selectedCategory != null
              ? selectedCategory
              : this.selectedCategory),
      selectedHabitat: clearHabitat
          ? null
          : (selectedHabitat != null ? selectedHabitat : this.selectedHabitat),
      selectedSize: clearSize
          ? null
          : (selectedSize != null ? selectedSize : this.selectedSize),
      selectedActivity: clearActivity
          ? null
          : (selectedActivity != null
              ? selectedActivity
              : this.selectedActivity),
      favoriteIds: favoriteIds ?? this.favoriteIds,
      discoveredIds: discoveredIds ?? this.discoveredIds,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        allAnimals,
        filteredAnimals,
        searchQuery,
        selectedCategory,
        selectedHabitat,
        selectedSize,
        selectedActivity,
        favoriteIds,
        discoveredIds,
        isLoading,
      ];
}
