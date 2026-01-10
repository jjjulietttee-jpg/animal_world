import '../../domain/entities/animal.dart';

class AnimalModel extends Animal {
  const AnimalModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imagePath,
  });

  factory AnimalModel.fromJson(Map<String, dynamic> json) {
    return AnimalModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imagePath: json['imagePath'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imagePath': imagePath,
    };
  }
}

