import '../../../../core/constants/image_source.dart';
import '../models/animal_model.dart';

abstract class AnimalLocalDataSource {
  Future<List<AnimalModel>> getAnimals();
  Future<AnimalModel> getAnimalById(String id);
}

class AnimalLocalDataSourceImpl implements AnimalLocalDataSource {
  @override
  Future<List<AnimalModel>> getAnimals() async {
    await Future.delayed(const Duration(milliseconds: 100));

    return [
      const AnimalModel(
        id: '1',
        name: 'Лев',
        description:
            'Король джунглей, крупное хищное млекопитающее семейства кошачьих.',
        imagePath: ImageSource.lion,
      ),
      const AnimalModel(
        id: '2',
        name: 'Слон',
        description: 'Крупнейшее наземное млекопитающее с длинным хоботом.',
        imagePath: ImageSource.elephant,
      ),
      const AnimalModel(
        id: '3',
        name: 'Тигр',
        description: 'Крупная полосатая кошка, один из самых опасных хищников.',
        imagePath: ImageSource.tiger,
      ),
      const AnimalModel(
        id: '4',
        name: 'Жираф',
        description: 'Самое высокое животное в мире с длинной шеей.',
        imagePath: ImageSource.giraffe,
      ),
      const AnimalModel(
        id: '5',
        name: 'Зебра',
        description: 'Африканское животное с черно-белыми полосками.',
        imagePath: ImageSource.zebra,
      ),
      const AnimalModel(
        id: '6',
        name: 'Обезьяна',
        description: 'Примат, живущий на деревьях, очень умное животное.',
        imagePath: ImageSource.monkey,
      ),
      const AnimalModel(
        id: '8',
        name: 'Кенгуру',
        description:
            'Австралийское сумчатое животное с мощными задними лапами.',
        imagePath: ImageSource.kangaroo,
      ),
      const AnimalModel(
        id: '9',
        name: 'Пингвин',
        description: 'Нелетающая птица, отличный пловец, живет в Антарктиде.',
        imagePath: ImageSource.penguin,
      ),
      const AnimalModel(
        id: '10',
        name: 'Дельфин',
        description:
            'Умное морское млекопитающее, известное своей дружелюбностью.',
        imagePath: ImageSource.dolphin,
      ),
    ];
  }

  @override
  Future<AnimalModel> getAnimalById(String id) async {
    final animals = await getAnimals();
    return animals.firstWhere((animal) => animal.id == id);
  }
}
