import 'dart:math';

import '../../../lessons/domain/repositories/lesson_repository.dart';
import '../entities/question.dart';

// makes one question for every word of the deck,
// the wrong answers are meanings of other words from the same deck
class MakeQuiz {
  final LessonRepository repository;
  final Random random;

  MakeQuiz(this.repository, {Random? random}) : random = random ?? Random();

  Future<List<Question>> call(String categoryId) async {
    final words = await repository.getWords(categoryId);
    final questions = <Question>[];

    for (final word in words) {
      final others = words.where((other) => other != word).toList();
      others.shuffle(random);

      final options = [word.english];
      for (final other in others.take(3)) {
        options.add(other.english);
      }
      options.shuffle(random);

      questions.add(Question(word: word, options: options));
    }

    questions.shuffle(random);
    return questions;
  }
}
