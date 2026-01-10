import 'package:equatable/equatable.dart';

class Animal extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imagePath;

  const Animal({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
  });

  @override
  List<Object> get props => [id, name, description, imagePath];
}

