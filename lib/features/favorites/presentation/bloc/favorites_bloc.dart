import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_favorite_animals.dart';
import '../../domain/usecases/toggle_favorite_animal.dart';
import '../../domain/usecases/is_favorite_animal.dart';
import '../../../../core/services/storage_service.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoriteAnimals getFavoriteAnimals;
  final ToggleFavoriteAnimal toggleFavoriteAnimal;
  final IsFavoriteAnimal isFavoriteAnimal;
  final StorageService storageService;

  FavoritesBloc({
    required this.getFavoriteAnimals,
    required this.toggleFavoriteAnimal,
    required this.isFavoriteAnimal,
    required this.storageService,
  }) : super(const FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesLoading());
    try {
      final animals = await getFavoriteAnimals();
      final favoriteIds = await storageService.getFavoriteAnimalsIds();
      emit(FavoritesLoaded(
        animals: animals,
        favoriteIds: favoriteIds.toSet(),
      ));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      final isFavorite = await toggleFavoriteAnimal(event.animalId);
      final favoriteIds = await storageService.getFavoriteAnimalsIds();
      
      if (state is FavoritesLoaded) {
        final currentState = state as FavoritesLoaded;
        final updatedAnimals = isFavorite
            ? currentState.animals
            : currentState.animals.where((a) => a.id != event.animalId).toList();
        
        emit(FavoritesLoaded(
          animals: updatedAnimals,
          favoriteIds: favoriteIds.toSet(),
        ));
      } else {
        final animals = await getFavoriteAnimals();
        emit(FavoritesLoaded(
          animals: animals,
          favoriteIds: favoriteIds.toSet(),
        ));
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}
