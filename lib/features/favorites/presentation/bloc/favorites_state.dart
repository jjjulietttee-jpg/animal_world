import 'package:equatable/equatable.dart';
import '../../../game/domain/entities/animal.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

class FavoritesLoaded extends FavoritesState {
  final List<Animal> animals;
  final Set<String> favoriteIds;

  const FavoritesLoaded({
    required this.animals,
    required this.favoriteIds,
  });

  @override
  List<Object> get props => [animals, favoriteIds];
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object> get props => [message];
}
