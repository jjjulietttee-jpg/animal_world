import '../entities/animal.dart';
import '../repositories/animal_repository.dart';

class GetAnimals {
  final AnimalRepository repository;

  GetAnimals(this.repository);

  Future<List<Animal>> call() async {
    return await repository.getAnimals();
  }
}

