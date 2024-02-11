import '../entities/category.dart';
import '../entities/word.dart';

abstract class LessonRepository {
  Future<List<Category>> getCategories();

  Future<List<Word>> getWords(String categoryId);
}
