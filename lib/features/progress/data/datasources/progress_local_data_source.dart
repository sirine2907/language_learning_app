import 'package:shared_preferences/shared_preferences.dart';

class ProgressLocalDataSource {
  static const _scorePrefix = 'best_score_';
  static const _daysKey = 'practice_days';

  final SharedPreferences prefs;

  ProgressLocalDataSource(this.prefs);

  Map<String, int> getBestScores() {
    final scores = <String, int>{};
    for (final key in prefs.getKeys()) {
      if (key.startsWith(_scorePrefix)) {
        final categoryId = key.substring(_scorePrefix.length);
        scores[categoryId] = prefs.getInt(key) ?? 0;
      }
    }
    return scores;
  }

  Future<void> saveBestScore(String categoryId, int score) async {
    await prefs.setInt('$_scorePrefix$categoryId', score);
  }

  // saved like "2024-03-02"
  List<String> getPracticeDays() {
    return prefs.getStringList(_daysKey) ?? [];
  }

  Future<void> savePracticeDays(List<String> days) async {
    await prefs.setStringList(_daysKey, days);
  }
}
