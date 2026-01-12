import 'package:equatable/equatable.dart';
import '../../../game/domain/entities/animal_category.dart';

abstract class AnimalsListEvent extends Equatable {
  const AnimalsListEvent();

  @override
  List<Object> get props => [];
}

class LoadAnimals extends AnimalsListEvent {
  const LoadAnimals();
}

class SearchAnimals extends AnimalsListEvent {
  final String query;

  const SearchAnimals(this.query);

  @override
  List<Object> get props => [query];
}

class FilterByCategory extends AnimalsListEvent {
  final AnimalCategory? category;

  const FilterByCategory(this.category);

  @override
  List<Object> get props => [category ?? ''];
}

class FilterByHabitat extends AnimalsListEvent {
  final AnimalHabitat? habitat;

  const FilterByHabitat(this.habitat);

  @override
  List<Object> get props => [habitat ?? ''];
}

class FilterBySize extends AnimalsListEvent {
  final AnimalSize? size;

  const FilterBySize(this.size);

  @override
  List<Object> get props => [size ?? ''];
}

class FilterByActivity extends AnimalsListEvent {
  final AnimalActivity? activity;

  const FilterByActivity(this.activity);

  @override
  List<Object> get props => [activity ?? ''];
}

class ClearFilters extends AnimalsListEvent {
  const ClearFilters();
}
