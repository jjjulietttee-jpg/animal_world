import '../entities/animal.dart';

abstract class AnimalRepository {
  Future<List<Animal>> getAnimals();
  Future<Animal> getAnimalById(String id);
}

