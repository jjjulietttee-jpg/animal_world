import '../../domain/entities/animal.dart';
import '../../domain/repositories/animal_repository.dart';
import '../datasources/animal_local_datasource.dart';

class AnimalRepositoryImpl implements AnimalRepository {
  final AnimalLocalDataSource localDataSource;

  AnimalRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Animal>> getAnimals() async {
    final models = await localDataSource.getAnimals();
    return models;
  }

  @override
  Future<Animal> getAnimalById(String id) async {
    final model = await localDataSource.getAnimalById(id);
    return model;
  }
}
