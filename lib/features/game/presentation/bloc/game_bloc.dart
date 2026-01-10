import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../../../core/bloc/bloc_providers.dart';
import '../../../../core/services/storage_service.dart';
import '../../domain/entities/animal.dart';
import '../../domain/usecases/get_animals.dart';
import '../../domain/usecases/get_random_animals.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GetAnimals getAnimals;
  final GetRandomAnimals getRandomAnimals;
  final StorageService storageService;
  final Random _random = Random();
  List<Animal> _usedAnimals = [];
  
  Talker get _talker => getIt<Talker>();

  GameBloc({
    required this.getAnimals,
    required this.getRandomAnimals,
    required this.storageService,
  }) : super(
         const GameState(
           allAnimals: [],
           answerOptions: [],
           score: 0,
           isAnswered: false,
           isLoading: true,
           isGameOver: false,
         ),
       ) {
    on<GameStarted>(_onGameStarted);
    on<AnswerSelected>(_onAnswerSelected);
    on<NextQuestion>(_onNextQuestion);
    on<GameReset>(_onGameReset);
    on<GameStateLoaded>(_onGameStateLoaded);
  }

  Future<void> _onGameStarted(
    GameStarted event,
    Emitter<GameState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final animals = await getAnimals();

      if (animals.isEmpty) {
        emit(
          state.copyWith(allAnimals: [], isLoading: false, isGameOver: false),
        );
        return;
      }

      bool shouldStartNewGame = event.forceNew;
      
      if (!event.forceNew) {
        final savedState = await storageService.loadGameState();
        if (savedState['currentAnimalId'] != null) {
          final savedAnimalId = savedState['currentAnimalId'] as String;
          try {
            final savedAnimal = animals.firstWhere(
              (animal) => animal.id == savedAnimalId,
            );

            final usedIds = savedState['usedAnimalsIds'] as List<String>;
            _usedAnimals = animals.where((a) => usedIds.contains(a.id)).toList();

            final options = savedState['answerOptions'] as List<String>;
            if (options.isNotEmpty && options.length == 4) {
              emit(
                state.copyWith(
                  allAnimals: animals,
                  currentAnimal: savedAnimal,
                  answerOptions: options,
                  score: savedState['score'] as int,
                  isAnswered: savedState['isAnswered'] as bool,
                  selectedAnswer: savedState['selectedAnswer'] as String?,
                  correctAnswer: savedState['correctAnswer'] as String?,
                  isLoading: false,
                ),
              );
              return;
            }
          } catch (e) {
            // Saved animal not found or invalid, continue with new game
            shouldStartNewGame = true;
          }
        } else {
          shouldStartNewGame = true;
        }
      }

      if (shouldStartNewGame) {
        await storageService.incrementGamesPlayed();
      }

      final availableAnimals = animals
          .where((animal) => !_usedAnimals.contains(animal))
          .toList();

      if (availableAnimals.isEmpty && animals.isNotEmpty) {
        _usedAnimals.clear();
        availableAnimals.addAll(animals);
      }

      if (availableAnimals.isNotEmpty) {
        final currentAnimal =
            availableAnimals[_random.nextInt(availableAnimals.length)];
        _usedAnimals.add(currentAnimal);

        final options = await _generateAnswerOptions(currentAnimal, animals);

        await storageService.saveGameState(
          currentAnimalId: currentAnimal.id,
          score: 0,
          usedAnimalsIds: _usedAnimals.map((a) => a.id).toList(),
          answerOptions: options,
        );

        emit(
          state.copyWith(
            allAnimals: animals,
            currentAnimal: currentAnimal,
            answerOptions: options,
            isLoading: false,
            isAnswered: false,
            selectedAnswer: null,
            correctAnswer: null,
            score: 0,
          ),
        );
      } else {
        emit(
          state.copyWith(
            allAnimals: animals,
            isLoading: false,
            isGameOver: true,
          ),
        );
      }
    } catch (e, stackTrace) {
      _talker.error('Error in GameBloc._onGameStarted', e, stackTrace);
      emit(
        state.copyWith(
          allAnimals: [],
          isLoading: false,
          isGameOver: false,
        ),
      );
    }
  }

  Future<void> _onGameStateLoaded(
    GameStateLoaded event,
    Emitter<GameState> emit,
  ) async {
    final savedState = await storageService.loadGameState();
    if (savedState['currentAnimalId'] != null && state.allAnimals.isNotEmpty) {
      final savedAnimalId = savedState['currentAnimalId'] as String;
      final savedAnimal = state.allAnimals.firstWhere(
        (animal) => animal.id == savedAnimalId,
        orElse: () => state.allAnimals.first,
      );

      final usedIds = savedState['usedAnimalsIds'] as List<String>;
      _usedAnimals = state.allAnimals
          .where((a) => usedIds.contains(a.id))
          .toList();

      emit(
        state.copyWith(
          currentAnimal: savedAnimal,
          answerOptions: savedState['answerOptions'] as List<String>,
          score: savedState['score'] as int,
          isAnswered: savedState['isAnswered'] as bool,
          selectedAnswer: savedState['selectedAnswer'] as String?,
          correctAnswer: savedState['correctAnswer'] as String?,
        ),
      );
    }
  }

  Future<void> _onAnswerSelected(
    AnswerSelected event,
    Emitter<GameState> emit,
  ) async {
    if (state.isAnswered || state.currentAnimal == null) return;

    final isCorrect = event.selectedAnswer == state.currentAnimal!.name;
    final newScore = isCorrect ? state.score + 1 : state.score;

    await storageService.updateBestScore(newScore);
    await storageService.saveGameState(
      currentAnimalId: state.currentAnimal!.id,
      score: newScore,
      usedAnimalsIds: _usedAnimals.map((a) => a.id).toList(),
      isAnswered: true,
      selectedAnswer: event.selectedAnswer,
      correctAnswer: state.currentAnimal!.name,
      answerOptions: state.answerOptions,
    );

    emit(
      state.copyWith(
        isAnswered: true,
        selectedAnswer: event.selectedAnswer,
        correctAnswer: state.currentAnimal!.name,
        score: newScore,
      ),
    );
  }

  Future<void> _onNextQuestion(
    NextQuestion event,
    Emitter<GameState> emit,
  ) async {
    if (state.allAnimals.isEmpty) return;

    final availableAnimals = state.allAnimals
        .where((animal) => !_usedAnimals.contains(animal))
        .toList();

    if (availableAnimals.isEmpty) {
      _usedAnimals.clear();
      availableAnimals.addAll(state.allAnimals);
    }

    if (availableAnimals.isNotEmpty) {
      final currentAnimal =
          availableAnimals[_random.nextInt(availableAnimals.length)];
      _usedAnimals.add(currentAnimal);

      final options = await _generateAnswerOptions(
        currentAnimal,
        state.allAnimals,
      );

      await storageService.saveGameState(
        currentAnimalId: currentAnimal.id,
        score: state.score,
        usedAnimalsIds: _usedAnimals.map((a) => a.id).toList(),
        answerOptions: options,
        isAnswered: false,
      );

      emit(
        state.copyWith(
          currentAnimal: currentAnimal,
          answerOptions: options,
          isAnswered: false,
          selectedAnswer: null,
          correctAnswer: null,
        ),
      );
    } else {
      await storageService.updateBestScore(state.score);
      emit(state.copyWith(isGameOver: true));
    }
  }

  Future<void> _onGameReset(GameReset event, Emitter<GameState> emit) async {
    _usedAnimals.clear();
    await storageService.clearGameState();
    add(const GameStarted(forceNew: true));
  }

  Future<List<String>> _generateAnswerOptions(
    Animal correctAnimal,
    List<Animal> allAnimals,
  ) async {
    final options = <String>[correctAnimal.name];
    final otherAnimals = List<Animal>.from(allAnimals)
      ..removeWhere((animal) => animal.id == correctAnimal.id);

    otherAnimals.shuffle(_random);

    while (options.length < 4 && otherAnimals.isNotEmpty) {
      final animal = otherAnimals.removeAt(0);
      if (!options.contains(animal.name)) {
        options.add(animal.name);
      }
    }

    options.shuffle(_random);
    return options;
  }
}
