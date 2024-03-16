import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:language_learning_app/features/lessons/data/datasources/lesson_local_data_source.dart';
import 'package:language_learning_app/features/lessons/data/repositories/lesson_repository_impl.dart';
import 'package:language_learning_app/features/quiz/domain/usecases/make_quiz.dart';

void main() {
  late MakeQuiz makeQuiz;

  setUp(() {
    final repository = LessonRepositoryImpl(LessonLocalDataSource());
    makeQuiz = MakeQuiz(repository, random: Random(7));
  });

  test('makes one question for every word', () async {
    final questions = await makeQuiz('numbers');
    expect(questions.length, 10);
  });

  test('every question has 4 different options with the answer inside',
      () async {
    final questions = await makeQuiz('colors');

    for (final question in questions) {
      expect(question.options.length, 4);
      expect(question.options.toSet().length, 4);
      expect(question.options, contains(question.answer));
    }
  });
}
