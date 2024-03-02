import '../entities/progress.dart';

abstract class ProgressRepository {
  Future<Progress> getProgress();

  // score is null when I only studied the cards (no quiz)
  Future<void> saveResult(String categoryId, {int? score, required DateTime day});
}
