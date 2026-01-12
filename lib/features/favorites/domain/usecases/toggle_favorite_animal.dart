import '../../../../core/services/storage_service.dart';

class ToggleFavoriteAnimal {
  final StorageService storageService;

  ToggleFavoriteAnimal(this.storageService);

  Future<bool> call(String animalId) async {
    final isFavorite = await storageService.isFavoriteAnimal(animalId);
    if (isFavorite) {
      await storageService.removeFavoriteAnimal(animalId);
      return false;
    } else {
      await storageService.addFavoriteAnimal(animalId);
      return true;
    }
  }
}
