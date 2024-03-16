import 'package:flutter_test/flutter_test.dart';
import 'package:language_learning_app/features/progress/data/datasources/progress_local_data_source.dart';
import 'package:language_learning_app/features/progress/data/repositories/progress_repository_impl.dart';
import 'package:language_learning_app/features/progress/domain/entities/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Progress', () {
    final today = DateTime(2024, 3, 14);

    test('streak counts the days in a row', () {
      final progress = Progress(practiceDays: [
        DateTime(2024, 3, 12),
        DateTime(2024, 3, 13),
        DateTime(2024, 3, 14),
      ]);
      expect(progress.streak(today), 3);
    });

    test('not practicing yet today does not break the streak', () {
      final progress = Progress(practiceDays: [
        DateTime(2024, 3, 12),
        DateTime(2024, 3, 13),
      ]);
      expect(progress.streak(today), 2);
    });

    test('a missing day resets the streak', () {
      final progress = Progress(practiceDays: [
        DateTime(2024, 3, 10),
        DateTime(2024, 3, 14),
      ]);
      expect(progress.streak(today), 1);
    });

    test('score is 0 for a deck I never did', () {
      expect(const Progress().scoreFor('numbers'), 0);
    });
  });

  group('ProgressRepositoryImpl', () {
    late ProgressRepositoryImpl repository;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      repository = ProgressRepositoryImpl(ProgressLocalDataSource(prefs));
    });

    test('keeps only the best score', () async {
      final day = DateTime(2024, 3, 14);
      await repository.saveResult('colors', score: 80, day: day);
      await repository.saveResult('colors', score: 50, day: day);

      final progress = await repository.getProgress();
      expect(progress.scoreFor('colors'), 80);
    });

    test('saves the same day only once', () async {
      final day = DateTime(2024, 3, 14);
      await repository.saveResult('numbers', day: day);
      await repository.saveResult('colors', score: 60, day: day);

      final progress = await repository.getProgress();
      expect(progress.practiceDays.length, 1);
      expect(progress.practicedOn(day), isTrue);
    });
  });
}
