import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

class GameStarted extends GameEvent {
  final bool forceNew;

  const GameStarted({this.forceNew = false});

  @override
  List<Object?> get props => [forceNew];
}

class GameStateLoaded extends GameEvent {
  const GameStateLoaded();
}

class AnswerSelected extends GameEvent {
  final String selectedAnswer;

  const AnswerSelected(this.selectedAnswer);

  @override
  List<Object?> get props => [selectedAnswer];
}

class NextQuestion extends GameEvent {
  const NextQuestion();
}

class GameReset extends GameEvent {
  const GameReset();
}
