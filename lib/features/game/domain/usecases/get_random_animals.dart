import 'dart:math';
import '../entities/animal.dart';
import '../repositories/animal_repository.dart';

class GetRandomAnimals {
  final AnimalRepository repository;

  GetRandomAnimals(this.repository);

  Future<List<Animal>> call(int count) async {
    final allAnimals = await repository.getAnimals();
    final random = Random();
    final shuffled = List<Animal>.from(allAnimals)..shuffle(random);
    return shuffled.take(count).toList();
  }
}

