import '../entities/word.dart';
import '../repositories/lesson_repository.dart';

class GetWords {
  final LessonRepository repository;

  GetWords(this.repository);

  Future<List<Word>> call(String categoryId) {
    return repository.getWords(categoryId);
  }
}
