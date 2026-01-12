import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavorites extends FavoritesEvent {
  const LoadFavorites();
}

class ToggleFavorite extends FavoritesEvent {
  final String animalId;

  const ToggleFavorite(this.animalId);

  @override
  List<Object> get props => [animalId];
}
