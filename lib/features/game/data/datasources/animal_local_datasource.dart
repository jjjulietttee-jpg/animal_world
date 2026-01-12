import '../../../../core/constants/image_source.dart';
import '../../domain/entities/animal_category.dart';
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
      // Wild Animals
      const AnimalModel(
        id: 'lion',
        name: 'Lion',
        description:
            'The king of the jungle. Lions are large carnivorous mammals known for their majestic manes and powerful roars.',
        imagePath: ImageSource.lion,
        category: AnimalCategory.wildAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.large,
        activity: AnimalActivity.night,
        diet: 'Carnivore (antelopes, zebras, buffalo)',
        lifespan: '10-14 years',
        funFact: 'Lions can sleep up to 20 hours a day.',
      ),
      const AnimalModel(
        id: 'tiger',
        name: 'Tiger',
        description:
            'The largest cat species. Tigers are powerful predators with distinctive orange coats and black stripes.',
        imagePath: ImageSource.tiger,
        category: AnimalCategory.wildAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.large,
        activity: AnimalActivity.night,
        diet: 'Carnivore (deer, wild boar, monkeys)',
        lifespan: '10-15 years',
        funFact: 'Each tiger has unique stripes, like human fingerprints.',
      ),
      const AnimalModel(
        id: 'leopard',
        name: 'Leopard',
        description:
            'A graceful big cat with a spotted coat. Leopards are excellent climbers and can carry prey up trees.',
        imagePath: ImageSource.leopard,
        category: AnimalCategory.wildAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.large,
        activity: AnimalActivity.night,
        diet: 'Carnivore (small mammals, birds)',
        lifespan: '12-17 years',
        funFact: 'Leopards can run up to 58 km/h.',
      ),
      const AnimalModel(
        id: 'elephant',
        name: 'Elephant',
        description:
            'The largest land mammal. Elephants are known for their intelligence, memory, and long trunks.',
        imagePath: ImageSource.elephant,
        category: AnimalCategory.wildAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.large,
        activity: AnimalActivity.day,
        diet: 'Herbivore (grass, leaves, bark)',
        lifespan: '60-70 years',
        funFact: 'Elephants can recognize themselves in mirrors.',
      ),
      const AnimalModel(
        id: 'giraffe',
        name: 'Giraffe',
        description:
            'The tallest animal in the world. Giraffes use their long necks to reach leaves high in trees.',
        imagePath: ImageSource.giraffe,
        category: AnimalCategory.wildAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.large,
        activity: AnimalActivity.day,
        diet: 'Herbivore (acacia leaves, mimosa)',
        lifespan: '20-25 years',
        funFact: 'A giraffe\'s heart weighs about 11 kilograms.',
      ),
      const AnimalModel(
        id: 'zebra',
        name: 'Zebra',
        description:
            'African animals with black and white stripes. Zebras live in herds and use stripes for camouflage.',
        imagePath: ImageSource.zebra,
        category: AnimalCategory.wildAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.medium,
        activity: AnimalActivity.day,
        diet: 'Herbivore (grass, leaves)',
        lifespan: '20-30 years',
        funFact: 'Each zebra has a unique stripe pattern.',
      ),
      const AnimalModel(
        id: 'monkey',
        name: 'Monkey',
        description:
            'Intelligent primates that live in trees. Monkeys are known for their social behavior and problem-solving skills.',
        imagePath: ImageSource.monkey,
        category: AnimalCategory.wildAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.medium,
        activity: AnimalActivity.day,
        diet: 'Omnivore (fruits, nuts, insects)',
        lifespan: '15-30 years',
        funFact: 'Monkeys can use tools to get food.',
      ),
      const AnimalModel(
        id: 'kangaroo',
        name: 'Kangaroo',
        description:
            'Australian marsupials with powerful hind legs. Kangaroos carry their babies in pouches.',
        imagePath: ImageSource.kangaroo,
        category: AnimalCategory.wildAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.large,
        activity: AnimalActivity.night,
        diet: 'Herbivore (grass, leaves)',
        lifespan: '6-8 years',
        funFact: 'Kangaroos cannot move backwards.',
      ),
      const AnimalModel(
        id: 'koala',
        name: 'Koala',
        description:
            'Cute Australian marsupials that sleep in eucalyptus trees. Koalas eat only eucalyptus leaves.',
        imagePath: ImageSource.koala,
        category: AnimalCategory.wildAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.medium,
        activity: AnimalActivity.night,
        diet: 'Herbivore (eucalyptus leaves)',
        lifespan: '13-18 years',
        funFact: 'Koalas sleep up to 18 hours a day.',
      ),
      const AnimalModel(
        id: 'bear',
        name: 'Bear',
        description:
            'Large mammals with thick fur. Bears are omnivores and can be found in forests and mountains.',
        imagePath: ImageSource.bear,
        category: AnimalCategory.wildAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.large,
        activity: AnimalActivity.day,
        diet: 'Omnivore (berries, fish, honey)',
        lifespan: '20-30 years',
        funFact: 'Bears can run as fast as horses.',
      ),
      const AnimalModel(
        id: 'wolf',
        name: 'Wolf',
        description:
            'Social pack animals known for their howling. Wolves are skilled hunters and live in family groups.',
        imagePath: ImageSource.wolf,
        category: AnimalCategory.wildAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.large,
        activity: AnimalActivity.night,
        diet: 'Carnivore (deer, elk, small mammals)',
        lifespan: '6-8 years',
        funFact: 'Wolves can howl to communicate over long distances.',
      ),
      const AnimalModel(
        id: 'fox',
        name: 'Fox',
        description:
            'Clever small mammals with bushy tails. Foxes are adaptable and can live in many environments.',
        imagePath: ImageSource.fox,
        category: AnimalCategory.wildAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.small,
        activity: AnimalActivity.night,
        diet: 'Omnivore (small mammals, birds, fruits)',
        lifespan: '2-5 years',
        funFact:
            'Foxes have excellent hearing and can detect prey underground.',
      ),
      const AnimalModel(
        id: 'deer',
        name: 'Deer',
        description:
            'Graceful herbivores with antlers. Deer are fast runners and live in forests and meadows.',
        imagePath: ImageSource.deer,
        category: AnimalCategory.wildAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.medium,
        activity: AnimalActivity.day,
        diet: 'Herbivore (grass, leaves, twigs)',
        lifespan: '10-15 years',
        funFact: 'Only male deer grow antlers.',
      ),
      const AnimalModel(
        id: 'rhinoceros',
        name: 'Rhinoceros',
        description:
            'Large mammals with thick skin and horns. Rhinos are herbivores and live in Africa and Asia.',
        imagePath: ImageSource.rhinoceros,
        category: AnimalCategory.wildAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.large,
        activity: AnimalActivity.day,
        diet: 'Herbivore (grass, leaves)',
        lifespan: '40-50 years',
        funFact:
            'Rhino horns are made of keratin, the same material as human hair.',
      ),
      const AnimalModel(
        id: 'hippopotamus',
        name: 'Hippopotamus',
        description:
            'Large semi-aquatic mammals. Hippos spend most of their time in water to stay cool.',
        imagePath: ImageSource.hippopotamus,
        category: AnimalCategory.wildAnimals,
        habitat: AnimalHabitat.water,
        size: AnimalSize.large,
        activity: AnimalActivity.night,
        diet: 'Herbivore (grass)',
        lifespan: '40-50 years',
        funFact: 'Hippos can hold their breath for up to 5 minutes.',
      ),
      const AnimalModel(
        id: 'bison',
        name: 'Bison',
        description:
            'Large wild cattle with shaggy fur. Bison once roamed the Great Plains in huge herds.',
        imagePath: ImageSource.bison,
        category: AnimalCategory.wildAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.large,
        activity: AnimalActivity.day,
        diet: 'Herbivore (grass)',
        lifespan: '15-20 years',
        funFact: 'Bison can run up to 56 km/h.',
      ),
      const AnimalModel(
        id: 'llama',
        name: 'Llama',
        description:
            'South American camelids with long necks. Llamas are used as pack animals and for their wool.',
        imagePath: ImageSource.llama,
        category: AnimalCategory.wildAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.medium,
        activity: AnimalActivity.day,
        diet: 'Herbivore (grass, hay)',
        lifespan: '15-25 years',
        funFact: 'Llamas can spit when they feel threatened.',
      ),
      const AnimalModel(
        id: 'otter',
        name: 'Otter',
        description:
            'Playful aquatic mammals. Otters are excellent swimmers and use tools to crack open shells.',
        imagePath: ImageSource.otter,
        category: AnimalCategory.wildAnimals,
        habitat: AnimalHabitat.water,
        size: AnimalSize.medium,
        activity: AnimalActivity.day,
        diet: 'Carnivore (fish, crabs, shellfish)',
        lifespan: '10-15 years',
        funFact: 'Otters hold hands while sleeping to avoid drifting apart.',
      ),

      // Farm Animals
      const AnimalModel(
        id: 'cow',
        name: 'Cow',
        description:
            'Domesticated farm animals that provide milk and meat. Cows are gentle and social creatures.',
        imagePath: ImageSource.cow,
        category: AnimalCategory.farmAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.large,
        activity: AnimalActivity.day,
        diet: 'Herbivore (grass, hay)',
        lifespan: '18-22 years',
        funFact: 'Cows have four stomachs to digest grass.',
      ),
      const AnimalModel(
        id: 'pig',
        name: 'Pig',
        description:
            'Intelligent farm animals raised for meat. Pigs are very clean animals despite their reputation.',
        imagePath: ImageSource.pig,
        category: AnimalCategory.farmAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.medium,
        activity: AnimalActivity.day,
        diet: 'Omnivore (grains, vegetables, fruits)',
        lifespan: '15-20 years',
        funFact: 'Pigs are one of the smartest animals, smarter than dogs.',
      ),
      const AnimalModel(
        id: 'sheep',
        name: 'Sheep',
        description:
            'Woolly farm animals raised for wool and meat. Sheep live in flocks and follow their leader.',
        imagePath: ImageSource.sheep,
        category: AnimalCategory.farmAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.medium,
        activity: AnimalActivity.day,
        diet: 'Herbivore (grass, hay)',
        lifespan: '10-12 years',
        funFact:
            'Sheep have excellent memories and can remember faces for years.',
      ),
      const AnimalModel(
        id: 'goat',
        name: 'Goat',
        description:
            'Curious farm animals with horns. Goats are excellent climbers and eat almost anything.',
        imagePath: ImageSource.goat,
        category: AnimalCategory.farmAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.medium,
        activity: AnimalActivity.day,
        diet: 'Herbivore (grass, leaves, hay)',
        lifespan: '15-18 years',
        funFact:
            'Goats have rectangular pupils that give them excellent peripheral vision.',
      ),
      const AnimalModel(
        id: 'horse',
        name: 'Horse',
        description:
            'Beautiful animals used for riding and work. Horses are fast runners and form strong bonds with humans.',
        imagePath: ImageSource.horse,
        category: AnimalCategory.farmAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.large,
        activity: AnimalActivity.day,
        diet: 'Herbivore (grass, hay, grains)',
        lifespan: '25-30 years',
        funFact: 'Horses can sleep both standing up and lying down.',
      ),
      const AnimalModel(
        id: 'chicken',
        name: 'Chicken',
        description:
            'Common farm birds raised for eggs and meat. Chickens are social animals that live in flocks.',
        imagePath: ImageSource.chicken,
        category: AnimalCategory.farmAnimals,
        habitat: AnimalHabitat.land,
        size: AnimalSize.small,
        activity: AnimalActivity.day,
        diet: 'Omnivore (grains, seeds, insects)',
        lifespan: '5-10 years',
        funFact: 'Chickens can remember over 100 different faces.',
      ),

      // Pets
      const AnimalModel(
        id: 'dog',
        name: 'Dog',
        description:
            'Loyal companions and best friends. Dogs are intelligent, friendly, and love to play.',
        imagePath: ImageSource.dog,
        category: AnimalCategory.pets,
        habitat: AnimalHabitat.land,
        size: AnimalSize.medium,
        activity: AnimalActivity.day,
        diet: 'Omnivore (dog food, meat, vegetables)',
        lifespan: '10-13 years',
        funFact: 'Dogs can understand up to 250 words and gestures.',
      ),
      const AnimalModel(
        id: 'cat',
        name: 'Cat',
        description:
            'Independent and graceful pets. Cats are excellent hunters and love to nap in sunny spots.',
        imagePath: ImageSource.cat,
        category: AnimalCategory.pets,
        habitat: AnimalHabitat.land,
        size: AnimalSize.small,
        activity: AnimalActivity.night,
        diet: 'Carnivore (cat food, meat, fish)',
        lifespan: '12-18 years',
        funFact: 'Cats spend 70% of their lives sleeping.',
      ),
      const AnimalModel(
        id: 'hamster',
        name: 'Hamster',
        description:
            'Small furry pets that love to run on wheels. Hamsters are nocturnal and very active at night.',
        imagePath: ImageSource.hamster,
        category: AnimalCategory.pets,
        habitat: AnimalHabitat.land,
        size: AnimalSize.small,
        activity: AnimalActivity.night,
        diet: 'Omnivore (seeds, fruits, vegetables)',
        lifespan: '2-3 years',
        funFact: 'Hamsters can store food in their cheeks.',
      ),
      // Birds
      const AnimalModel(
        id: 'penguin',
        name: 'Penguin',
        description:
            'Flightless birds that are excellent swimmers. Penguins live in cold climates and waddle on land.',
        imagePath: ImageSource.penguin,
        category: AnimalCategory.birds,
        habitat: AnimalHabitat.water,
        size: AnimalSize.medium,
        activity: AnimalActivity.day,
        diet: 'Carnivore (fish, squid, krill)',
        lifespan: '15-20 years',
        funFact: 'Penguins can dive up to 500 meters deep.',
      ),
      const AnimalModel(
        id: 'owl',
        name: 'Owl',
        description:
            'Wise nocturnal birds with excellent night vision. Owls are silent hunters with sharp talons.',
        imagePath: ImageSource.owl,
        category: AnimalCategory.birds,
        habitat: AnimalHabitat.air,
        size: AnimalSize.medium,
        activity: AnimalActivity.night,
        diet: 'Carnivore (mice, small birds)',
        lifespan: '10-15 years',
        funFact: 'Owls can turn their heads 270 degrees.',
      ),
      const AnimalModel(
        id: 'parrot',
        name: 'Parrot',
        description:
            'Colorful tropical birds known for mimicking sounds. Parrots are very social and intelligent.',
        imagePath: ImageSource.parrot,
        category: AnimalCategory.birds,
        habitat: AnimalHabitat.air,
        size: AnimalSize.small,
        activity: AnimalActivity.day,
        diet: 'Omnivore (seeds, fruits, nuts)',
        lifespan: '20-80 years',
        funFact: 'Parrots can remember up to 1000 words.',
      ),

      // Sea Animals
      const AnimalModel(
        id: 'dolphin',
        name: 'Dolphin',
        description:
            'Intelligent marine mammals known for their friendliness. Dolphins use echolocation to find food.',
        imagePath: ImageSource.dolphin,
        category: AnimalCategory.seaAnimals,
        habitat: AnimalHabitat.water,
        size: AnimalSize.large,
        activity: AnimalActivity.day,
        diet: 'Carnivore (fish, squid)',
        lifespan: '20-30 years',
        funFact: 'Dolphins sleep with one eye open.',
      ),
      const AnimalModel(
        id: 'shark',
        name: 'Shark',
        description:
            'Powerful ocean predators with sharp teeth. Sharks are ancient creatures that have existed for millions of years.',
        imagePath: ImageSource.shark,
        category: AnimalCategory.seaAnimals,
        habitat: AnimalHabitat.water,
        size: AnimalSize.large,
        activity: AnimalActivity.day,
        diet: 'Carnivore (fish, seals, sea lions)',
        lifespan: '20-30 years',
        funFact: 'Sharks can detect a drop of blood from a kilometer away.',
      ),
      const AnimalModel(
        id: 'octopus',
        name: 'Octopus',
        description:
            'Intelligent sea creatures with eight arms. Octopuses can change color and shape to camouflage.',
        imagePath: ImageSource.octopus,
        category: AnimalCategory.seaAnimals,
        habitat: AnimalHabitat.water,
        size: AnimalSize.medium,
        activity: AnimalActivity.night,
        diet: 'Carnivore (crabs, fish, shellfish)',
        lifespan: '1-5 years',
        funFact: 'Octopuses have three hearts and blue blood.',
      ),

      // Reptiles
      const AnimalModel(
        id: 'turtle',
        name: 'Turtle',
        description:
            'Reptiles with protective shells. Turtles can live both in water and on land.',
        imagePath: ImageSource.turtle,
        category: AnimalCategory.reptiles,
        habitat: AnimalHabitat.water,
        size: AnimalSize.medium,
        activity: AnimalActivity.day,
        diet: 'Omnivore (algae, fish, plants)',
        lifespan: '50-100 years',
        funFact: 'Turtles can live for more than 100 years.',
      ),
      const AnimalModel(
        id: 'snake',
        name: 'Snake',
        description:
            'Legless reptiles that move by slithering. Some snakes are venomous, others use constriction.',
        imagePath: ImageSource.snake,
        category: AnimalCategory.reptiles,
        habitat: AnimalHabitat.land,
        size: AnimalSize.medium,
        activity: AnimalActivity.night,
        diet: 'Carnivore (rodents, birds, eggs)',
        lifespan: '10-30 years',
        funFact: 'Snakes can open their mouths 150 degrees wide.',
      ),
      const AnimalModel(
        id: 'crocodile',
        name: 'Crocodile',
        description:
            'Large reptiles with powerful jaws. Crocodiles are ancient predators that live in freshwater.',
        imagePath: ImageSource.crocodile,
        category: AnimalCategory.reptiles,
        habitat: AnimalHabitat.water,
        size: AnimalSize.large,
        activity: AnimalActivity.night,
        diet: 'Carnivore (fish, birds, mammals)',
        lifespan: '70-100 years',
        funFact: 'Crocodiles can go without eating for up to a year.',
      ),

      // Insects
      const AnimalModel(
        id: 'butterfly',
        name: 'Butterfly',
        description:
            'Beautiful insects with colorful wings. Butterflies go through metamorphosis from caterpillar to butterfly.',
        imagePath: ImageSource.butterfly,
        category: AnimalCategory.insects,
        habitat: AnimalHabitat.air,
        size: AnimalSize.small,
        activity: AnimalActivity.day,
        diet: 'Herbivore (nectar, pollen)',
        lifespan: '2-4 weeks',
        funFact: 'Butterflies taste with their feet.',
      ),
      const AnimalModel(
        id: 'bee',
        name: 'Bee',
        description:
            'Hardworking insects that pollinate plants and make honey. Bees live in hives in large families.',
        imagePath: ImageSource.bee,
        category: AnimalCategory.insects,
        habitat: AnimalHabitat.air,
        size: AnimalSize.small,
        activity: AnimalActivity.day,
        diet: 'Herbivore (nectar, pollen)',
        lifespan: '4-6 weeks',
        funFact: 'Bees dance to show other bees where to find food.',
      ),
      const AnimalModel(
        id: 'ladybug',
        name: 'Ladybug',
        description:
            'Small colorful beetles with spotted wings. Ladybugs are beneficial insects that eat garden pests.',
        imagePath: ImageSource.ladybug,
        category: AnimalCategory.insects,
        habitat: AnimalHabitat.land,
        size: AnimalSize.small,
        activity: AnimalActivity.day,
        diet: 'Carnivore (aphids, mites)',
        lifespan: '1-2 years',
        funFact: 'A single ladybug can eat up to 5000 aphids in its lifetime.',
      ),
      const AnimalModel(
        id: 'frog',
        name: 'Frog',
        description:
            'Amphibians that live in water and on land. Frogs are known for jumping and making loud croaking sounds.',
        imagePath: ImageSource.frog,
        category: AnimalCategory.insects,
        habitat: AnimalHabitat.water,
        size: AnimalSize.small,
        activity: AnimalActivity.night,
        diet: 'Carnivore (insects, worms)',
        lifespan: '5-10 years',
        funFact: 'Frogs can absorb water through their skin.',
      ),
    ];
  }

  @override
  Future<AnimalModel> getAnimalById(String id) async {
    final animals = await getAnimals();
    return animals.firstWhere((animal) => animal.id == id);
  }
}
