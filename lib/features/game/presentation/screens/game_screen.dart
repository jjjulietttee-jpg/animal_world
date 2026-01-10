import 'package:animal_world/core/navigation/data/constants/navigation_constants.dart';
import 'package:animal_world/core/shared/widgets/gradient_button.dart';
import 'package:animal_world/core/theme/app_border_radius.dart';
import 'package:animal_world/core/theme/app_colors.dart';
import 'package:animal_world/core/theme/app_fonts.dart';
import 'package:animal_world/core/theme/app_spacing.dart';
import 'package:animal_world/features/game/presentation/bloc/game_bloc.dart';
import 'package:animal_world/features/game/presentation/bloc/game_event.dart';
import 'package:animal_world/features/game/presentation/bloc/game_state.dart';
import 'package:animal_world/features/game/presentation/widgets/answer_button_widget.dart';
import 'package:animal_world/features/game/presentation/widgets/animal_image_widget.dart';
import 'package:animal_world/features/game/presentation/widgets/score_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final bloc = context.read<GameBloc>();
        final currentState = bloc.state;
        if (currentState.allAnimals.isEmpty || currentState.currentAnimal == null) {
          bloc.add(const GameStarted());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.go(NavigationConstants.home);
            },
          ),
          title: const Text('Угадай животное'),
          actions: [
            BlocBuilder<GameBloc, GameState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.only(right: AppSpacing.md),
                  child: ScoreWidget(score: state.score),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.isGameOver) {
              return _buildGameOverView(context, state);
            }

            if (state.allAnimals.isEmpty && !state.isLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Нет доступных животных', style: AppFonts.bodyLarge),
                    SizedBox(height: AppSpacing.md),
                    GradientButton(
                      text: 'Попробовать снова',
                      onPressed: () {
                        context.read<GameBloc>().add(
                          const GameStarted(forceNew: true),
                        );
                      },
                    ),
                  ],
                ),
              );
            }

            if (state.currentAnimal == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return _buildGameView(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildGameView(BuildContext context, GameState state) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppBorderRadius.xl),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.glowOrange,
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                    BoxShadow(
                      color: AppColors.shadowMedium,
                      blurRadius: 20,
                      spreadRadius: 0,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: AnimalImageWidget(
                  imagePath: state.currentAnimal!.imagePath,
                  height: 300,
                ),
              ),
              SizedBox(height: AppSpacing.xl),
              ...state.answerOptions.map((answer) {
                final isSelected =
                    state.isAnswered && state.selectedAnswer == answer;
                final isCorrect =
                    state.isAnswered && state.correctAnswer == answer;
                final isWrong =
                    state.isAnswered &&
                    state.selectedAnswer == answer &&
                    answer != state.correctAnswer;

                return AnswerButtonWidget(
                  text: answer,
                  onPressed: state.isAnswered
                      ? null
                      : () {
                          context.read<GameBloc>().add(AnswerSelected(answer));
                        },
                  isSelected: isSelected,
                  isCorrect: isCorrect,
                  isWrong: isWrong,
                );
              }),
              if (state.isAnswered) ...[
                SizedBox(height: AppSpacing.lg),
                GradientButton(
                  text: 'Следующий вопрос',
                  onPressed: () {
                    context.read<GameBloc>().add(const NextQuestion());
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameOverView(BuildContext context, GameState state) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.accentYellow, AppColors.primaryOrange],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.glowYellow,
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.celebration,
                size: 80,
                color: AppColors.white,
              ),
            ),
            SizedBox(height: AppSpacing.xl),
            Text(
              'Игра завершена!',
              style: AppFonts.displayLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.md),
            Text(
              'Ваш счет: ${state.score}',
              style: AppFonts.headlineLarge.copyWith(
                color: AppColors.primaryOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.xl),
            GradientButton(
              text: 'Начать заново',
              onPressed: () {
                context.read<GameBloc>().add(const GameReset());
              },
            ),
          ],
        ),
      ),
    );
  }
}
