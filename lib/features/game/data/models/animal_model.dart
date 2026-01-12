import '../../domain/entities/animal.dart';
import '../../domain/entities/animal_category.dart';

class AnimalModel extends Animal {
  const AnimalModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imagePath,
    required super.category,
    required super.habitat,
    required super.size,
    required super.activity,
    required super.diet,
    required super.lifespan,
    required super.funFact,
  });

  factory AnimalModel.fromJson(Map<String, dynamic> json) {
    return AnimalModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imagePath: json['imagePath'] as String,
      category: AnimalCategory.values.firstWhere(
        (e) => e.name == json['category'] as String,
      ),
      habitat: AnimalHabitat.values.firstWhere(
        (e) => e.name == json['habitat'] as String,
      ),
      size: AnimalSize.values.firstWhere(
        (e) => e.name == json['size'] as String,
      ),
      activity: AnimalActivity.values.firstWhere(
        (e) => e.name == json['activity'] as String,
      ),
      diet: json['diet'] as String,
      lifespan: json['lifespan'] as String,
      funFact: json['funFact'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imagePath': imagePath,
      'category': category.name,
      'habitat': habitat.name,
      'size': size.name,
      'activity': activity.name,
      'diet': diet,
      'lifespan': lifespan,
      'funFact': funFact,
    };
  }
}

