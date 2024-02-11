import '../entities/category.dart';
import '../repositories/lesson_repository.dart';

class GetCategories {
  final LessonRepository repository;

  GetCategories(this.repository);

  Future<List<Category>> call() {
    return repository.getCategories();
  }
}
