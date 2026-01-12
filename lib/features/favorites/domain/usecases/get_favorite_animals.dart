import '../../../game/domain/entities/animal.dart';
import '../../../game/domain/repositories/animal_repository.dart';
import '../../../../core/services/storage_service.dart';

class GetFavoriteAnimals {
  final AnimalRepository animalRepository;
  final StorageService storageService;

  GetFavoriteAnimals({
    required this.animalRepository,
    required this.storageService,
  });

  Future<List<Animal>> call() async {
    final favoriteIds = await storageService.getFavoriteAnimalsIds();
    if (favoriteIds.isEmpty) {
      return [];
    }
    final allAnimals = await animalRepository.getAnimals();
    return allAnimals.where((animal) => favoriteIds.contains(animal.id)).toList();
  }
}
