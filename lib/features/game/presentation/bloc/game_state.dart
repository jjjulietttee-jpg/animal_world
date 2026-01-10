import 'package:equatable/equatable.dart';
import '../../domain/entities/animal.dart';

class GameState extends Equatable {
  final List<Animal> allAnimals;
  final Animal? currentAnimal;
  final List<String> answerOptions;
  final int score;
  final bool isAnswered;
  final String? selectedAnswer;
  final String? correctAnswer;
  final bool isLoading;
  final bool isGameOver;

  const GameState({
    required this.allAnimals,
    this.currentAnimal,
    required this.answerOptions,
    required this.score,
    required this.isAnswered,
    this.selectedAnswer,
    this.correctAnswer,
    required this.isLoading,
    required this.isGameOver,
  });

  GameState copyWith({
    List<Animal>? allAnimals,
    Animal? currentAnimal,
    List<String>? answerOptions,
    int? score,
    bool? isAnswered,
    String? selectedAnswer,
    String? correctAnswer,
    bool? isLoading,
    bool? isGameOver,
    bool clearCurrentAnimal = false,
    bool clearSelectedAnswer = false,
    bool clearCorrectAnswer = false,
  }) {
    return GameState(
      allAnimals: allAnimals ?? this.allAnimals,
      currentAnimal: clearCurrentAnimal
          ? null
          : (currentAnimal ?? this.currentAnimal),
      answerOptions: answerOptions ?? this.answerOptions,
      score: score ?? this.score,
      isAnswered: isAnswered ?? this.isAnswered,
      selectedAnswer: clearSelectedAnswer
          ? null
          : (selectedAnswer ?? this.selectedAnswer),
      correctAnswer: clearCorrectAnswer
          ? null
          : (correctAnswer ?? this.correctAnswer),
      isLoading: isLoading ?? this.isLoading,
      isGameOver: isGameOver ?? this.isGameOver,
    );
  }

  @override
  List<Object?> get props => [
    allAnimals,
    currentAnimal,
    answerOptions,
    score,
    isAnswered,
    selectedAnswer,
    correctAnswer,
    isLoading,
    isGameOver,
  ];
}
