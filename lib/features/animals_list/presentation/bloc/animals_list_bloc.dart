import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../game/domain/usecases/get_animals.dart';
import '../../../game/domain/entities/animal.dart';
import '../../../../core/services/storage_service.dart';
import 'animals_list_event.dart';
import 'animals_list_state.dart';

class AnimalsListBloc extends Bloc<AnimalsListEvent, AnimalsListState> {
  final GetAnimals getAnimals;
  final StorageService storageService;

  AnimalsListBloc({
    required this.getAnimals,
    required this.storageService,
  }) : super(AnimalsListState.initial()) {
    on<LoadAnimals>(_onLoadAnimals);
    on<SearchAnimals>(_onSearchAnimals);
    on<FilterByCategory>(_onFilterByCategory);
    on<FilterByHabitat>(_onFilterByHabitat);
    on<FilterBySize>(_onFilterBySize);
    on<FilterByActivity>(_onFilterByActivity);
    on<ClearFilters>(_onClearFilters);
  }

  Future<void> _onLoadAnimals(
    LoadAnimals event,
    Emitter<AnimalsListState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final animals = await getAnimals();
      final favoriteIds = await storageService.getFavoriteAnimalsIds();
      final discoveredIds = await storageService.getViewedAnimalsIds();
      
      emit(state.copyWith(
        allAnimals: animals,
        filteredAnimals: animals,
        favoriteIds: favoriteIds.toSet(),
        discoveredIds: discoveredIds.toSet(),
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onSearchAnimals(
    SearchAnimals event,
    Emitter<AnimalsListState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
    _applyFilters(emit);
  }

  void _onFilterByCategory(
    FilterByCategory event,
    Emitter<AnimalsListState> emit,
  ) {
    final newState = event.category == null
        ? state.copyWith(clearCategory: true)
        : state.copyWith(selectedCategory: event.category);
    emit(newState);
    _applyFiltersWithState(emit, newState);
  }

  void _onFilterByHabitat(
    FilterByHabitat event,
    Emitter<AnimalsListState> emit,
  ) {
    final newState = event.habitat == null
        ? state.copyWith(clearHabitat: true)
        : state.copyWith(selectedHabitat: event.habitat);
    emit(newState);
    _applyFiltersWithState(emit, newState);
  }

  void _onFilterBySize(
    FilterBySize event,
    Emitter<AnimalsListState> emit,
  ) {
    final newState = event.size == null
        ? state.copyWith(clearSize: true)
        : state.copyWith(selectedSize: event.size);
    emit(newState);
    _applyFiltersWithState(emit, newState);
  }

  void _onFilterByActivity(
    FilterByActivity event,
    Emitter<AnimalsListState> emit,
  ) {
    final newState = event.activity == null
        ? state.copyWith(clearActivity: true)
        : state.copyWith(selectedActivity: event.activity);
    emit(newState);
    _applyFiltersWithState(emit, newState);
  }

  void _onClearFilters(
    ClearFilters event,
    Emitter<AnimalsListState> emit,
  ) {
    final newState = state.copyWith(
      searchQuery: '',
      clearCategory: true,
      clearHabitat: true,
      clearSize: true,
      clearActivity: true,
    );
    emit(newState);
    _applyFiltersWithState(emit, newState);
  }

  void _applyFilters(Emitter<AnimalsListState> emit) {
    _applyFiltersWithState(emit, state);
  }

  void _applyFiltersWithState(
    Emitter<AnimalsListState> emit,
    AnimalsListState currentState,
  ) {
    var filtered = List<Animal>.from(currentState.allAnimals);

    if (currentState.searchQuery.isNotEmpty) {
      final query = currentState.searchQuery.toLowerCase();
      filtered = filtered.where((animal) {
        return animal.name.toLowerCase().contains(query);
      }).toList();
    }

    final selectedCategory = currentState.selectedCategory;
    if (selectedCategory != null) {
      filtered = filtered.where((animal) {
        return animal.category == selectedCategory;
      }).toList();
    }

    final selectedHabitat = currentState.selectedHabitat;
    if (selectedHabitat != null) {
      filtered = filtered.where((animal) {
        return animal.habitat == selectedHabitat;
      }).toList();
    }

    final selectedSize = currentState.selectedSize;
    if (selectedSize != null) {
      filtered = filtered.where((animal) {
        return animal.size == selectedSize;
      }).toList();
    }

    final selectedActivity = currentState.selectedActivity;
    if (selectedActivity != null) {
      filtered = filtered.where((animal) {
        return animal.activity == selectedActivity;
      }).toList();
    }

    emit(currentState.copyWith(filteredAnimals: filtered));
  }
}
