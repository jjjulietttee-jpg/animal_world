import 'package:equatable/equatable.dart';
import 'animal_category.dart';

class Animal extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imagePath;
  final AnimalCategory category;
  final AnimalHabitat habitat;
  final AnimalSize size;
  final AnimalActivity activity;
  final String diet;
  final String lifespan;
  final String funFact;

  const Animal({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.category,
    required this.habitat,
    required this.size,
    required this.activity,
    required this.diet,
    required this.lifespan,
    required this.funFact,
  });

  @override
  List<Object> get props => [
        id,
        name,
        description,
        imagePath,
        category,
        habitat,
        size,
        activity,
        diet,
        lifespan,
        funFact,
      ];
}

