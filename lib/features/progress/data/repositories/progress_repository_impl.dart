import '../../domain/entities/progress.dart';
import '../../domain/repositories/progress_repository.dart';
import '../datasources/progress_local_data_source.dart';

class ProgressRepositoryImpl implements ProgressRepository {
  final ProgressLocalDataSource localDataSource;

  ProgressRepositoryImpl(this.localDataSource);

  @override
  Future<Progress> getProgress() async {
    final days = localDataSource
        .getPracticeDays()
        .map((day) => DateTime.parse(day))
        .toList();

    return Progress(
      bestScores: localDataSource.getBestScores(),
      practiceDays: days,
    );
  }

  @override
  Future<void> saveResult(
    String categoryId, {
    int? score,
    required DateTime day,
  }) async {
    if (score != null) {
      final oldScore = localDataSource.getBestScores()[categoryId] ?? 0;
      if (score > oldScore) {
        await localDataSource.saveBestScore(categoryId, score);
      }
    }

    final days = localDataSource.getPracticeDays();
    final dayText = _formatDay(day);
    if (!days.contains(dayText)) {
      days.add(dayText);
      await localDataSource.savePracticeDays(days);
    }
  }

  String _formatDay(DateTime day) {
    final month = day.month.toString().padLeft(2, '0');
    final dayOfMonth = day.day.toString().padLeft(2, '0');
    return '${day.year}-$month-$dayOfMonth';
  }
}
