import '../repositories/progress_repository.dart';

class SaveResult {
  final ProgressRepository repository;

  SaveResult(this.repository);

  Future<void> call(String categoryId, {int? score}) {
    return repository.saveResult(
      categoryId,
      score: score,
      day: DateTime.now(),
    );
  }
}
