import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _keyCurrentAnimalId = 'current_animal_id';
  static const String _keyGameScore = 'game_score';
  static const String _keyUsedAnimalsIds = 'used_animals_ids';
  static const String _keyIsAnswered = 'is_answered';
  static const String _keySelectedAnswer = 'selected_answer';
  static const String _keyCorrectAnswer = 'correct_answer';
  static const String _keyAnswerOptions = 'answer_options';

  static const String _keyGamesPlayed = 'games_played';
  static const String _keyBestScore = 'best_score';
  static const String _keyViewedAnimalsIds = 'viewed_animals_ids';

  SharedPreferences? _prefs;

  Future<SharedPreferences> get _preferences async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<void> saveGameState({
    String? currentAnimalId,
    int? score,
    List<String>? usedAnimalsIds,
    bool? isAnswered,
    String? selectedAnswer,
    String? correctAnswer,
    List<String>? answerOptions,
  }) async {
    final prefs = await _preferences;

    if (currentAnimalId != null) {
      await prefs.setString(_keyCurrentAnimalId, currentAnimalId);
    }
    if (score != null) {
      await prefs.setInt(_keyGameScore, score);
    }
    if (usedAnimalsIds != null) {
      await prefs.setStringList(_keyUsedAnimalsIds, usedAnimalsIds);
    }
    if (isAnswered != null) {
      await prefs.setBool(_keyIsAnswered, isAnswered);
    }
    if (selectedAnswer != null) {
      await prefs.setString(_keySelectedAnswer, selectedAnswer);
    } else {
      await prefs.remove(_keySelectedAnswer);
    }
    if (correctAnswer != null) {
      await prefs.setString(_keyCorrectAnswer, correctAnswer);
    } else {
      await prefs.remove(_keyCorrectAnswer);
    }
    if (answerOptions != null) {
      await prefs.setStringList(_keyAnswerOptions, answerOptions);
    }
  }

  Future<Map<String, dynamic>> loadGameState() async {
    final prefs = await _preferences;
    return {
      'currentAnimalId': prefs.getString(_keyCurrentAnimalId),
      'score': prefs.getInt(_keyGameScore) ?? 0,
      'usedAnimalsIds': prefs.getStringList(_keyUsedAnimalsIds) ?? [],
      'isAnswered': prefs.getBool(_keyIsAnswered) ?? false,
      'selectedAnswer': prefs.getString(_keySelectedAnswer),
      'correctAnswer': prefs.getString(_keyCorrectAnswer),
      'answerOptions': prefs.getStringList(_keyAnswerOptions) ?? [],
    };
  }

  Future<void> clearGameState() async {
    final prefs = await _preferences;
    await prefs.remove(_keyCurrentAnimalId);
    await prefs.remove(_keyGameScore);
    await prefs.remove(_keyUsedAnimalsIds);
    await prefs.remove(_keyIsAnswered);
    await prefs.remove(_keySelectedAnswer);
    await prefs.remove(_keyCorrectAnswer);
    await prefs.remove(_keyAnswerOptions);
  }

  Future<void> incrementAnimalsViewed(String animalId) async {
    try {
      final prefs = await _preferences;
      final viewedIds = prefs.getStringList(_keyViewedAnimalsIds) ?? [];
      if (!viewedIds.contains(animalId)) {
        viewedIds.add(animalId);
        await prefs.setStringList(_keyViewedAnimalsIds, viewedIds);
      }
    } catch (e) {
      // Ошибка сохранения - можно логировать через Talker
      rethrow;
    }
  }

  Future<int> getAnimalsViewed() async {
    try {
      final prefs = await _preferences;
      final viewedIds = prefs.getStringList(_keyViewedAnimalsIds) ?? [];
      return viewedIds.length;
    } catch (e) {
      return 0;
    }
  }

  Future<void> incrementGamesPlayed() async {
    try {
      final prefs = await _preferences;
      final current = prefs.getInt(_keyGamesPlayed) ?? 0;
      await prefs.setInt(_keyGamesPlayed, current + 1);
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getGamesPlayed() async {
    try {
      final prefs = await _preferences;
      return prefs.getInt(_keyGamesPlayed) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  Future<void> updateBestScore(int score) async {
    try {
      final prefs = await _preferences;
      final currentBest = prefs.getInt(_keyBestScore) ?? 0;
      if (score > currentBest) {
        await prefs.setInt(_keyBestScore, score);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getBestScore() async {
    try {
      final prefs = await _preferences;
      return prefs.getInt(_keyBestScore) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  Future<List<String>> getViewedAnimalsIds() async {
    try {
      final prefs = await _preferences;
      return prefs.getStringList(_keyViewedAnimalsIds) ?? [];
    } catch (e) {
      return [];
    }
  }

  Future<void> resetProgress() async {
    try {
      final prefs = await _preferences;
      await prefs.remove(_keyGamesPlayed);
      await prefs.remove(_keyBestScore);
      await prefs.remove(_keyViewedAnimalsIds);
    } catch (e) {
      rethrow;
    }
  }
}
