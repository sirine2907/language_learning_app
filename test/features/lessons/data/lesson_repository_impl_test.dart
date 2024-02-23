import 'package:flutter_test/flutter_test.dart';
import 'package:language_learning_app/features/lessons/data/datasources/lesson_local_data_source.dart';
import 'package:language_learning_app/features/lessons/data/repositories/lesson_repository_impl.dart';

void main() {
  late LessonRepositoryImpl repository;

  setUp(() {
    repository = LessonRepositoryImpl(LessonLocalDataSource());
  });

  test('returns the 4 categories', () async {
    final categories = await repository.getCategories();

    expect(categories.length, 4);
    expect(categories.first.id, 'numbers');
  });

  test('word count of every category matches its words', () async {
    final categories = await repository.getCategories();

    for (final category in categories) {
      final words = await repository.getWords(category.id);
      expect(words.length, category.wordCount);
    }
  });

  test('every number has its own sound', () async {
    final words = await repository.getWords('numbers');
    final sounds = words.map((word) => word.sound).toSet();

    expect(sounds.length, words.length);
  });

  test('throws when the category does not exist', () {
    expect(() => repository.getWords('animals'), throwsException);
  });
}
