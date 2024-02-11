import '../../domain/entities/category.dart';
import '../../domain/entities/word.dart';
import '../../domain/repositories/lesson_repository.dart';
import '../datasources/lesson_local_data_source.dart';

class LessonRepositoryImpl implements LessonRepository {
  final LessonLocalDataSource localDataSource;

  LessonRepositoryImpl(this.localDataSource);

  @override
  Future<List<Category>> getCategories() async {
    return localDataSource.getCategories();
  }

  @override
  Future<List<Word>> getWords(String categoryId) async {
    return localDataSource.getWords(categoryId);
  }
}
