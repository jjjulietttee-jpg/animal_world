import '../../../../core/services/storage_service.dart';

class IsFavoriteAnimal {
  final StorageService storageService;

  IsFavoriteAnimal(this.storageService);

  Future<bool> call(String animalId) async {
    return await storageService.isFavoriteAnimal(animalId);
  }
}
