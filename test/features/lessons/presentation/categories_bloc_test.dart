import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:language_learning_app/features/lessons/domain/entities/category.dart';
import 'package:language_learning_app/features/lessons/domain/repositories/lesson_repository.dart';
import 'package:language_learning_app/features/lessons/domain/usecases/get_categories.dart';
import 'package:language_learning_app/features/lessons/presentation/bloc/categories/categories_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockLessonRepository extends Mock implements LessonRepository {}

void main() {
  late MockLessonRepository repository;

  const numbers = Category(
    id: 'numbers',
    title: 'Numbers',
    japaneseTitle: '数字',
    stamp: '数',
    color: 0xFFC8892B,
    wordCount: 10,
    level: 'Basic',
  );

  setUp(() {
    repository = MockLessonRepository();
  });

  blocTest<CategoriesBloc, CategoriesState>(
    'emits loaded with the categories',
    setUp: () {
      when(() => repository.getCategories()).thenAnswer((_) async => [numbers]);
    },
    build: () => CategoriesBloc(getCategories: GetCategories(repository)),
    act: (bloc) => bloc.add(const CategoriesRequested()),
    expect: () => [
      const CategoriesLoading(),
      const CategoriesLoaded([numbers]),
    ],
  );

  blocTest<CategoriesBloc, CategoriesState>(
    'emits error when loading fails',
    setUp: () {
      when(() => repository.getCategories()).thenThrow(Exception('oops'));
    },
    build: () => CategoriesBloc(getCategories: GetCategories(repository)),
    act: (bloc) => bloc.add(const CategoriesRequested()),
    expect: () => [
      const CategoriesLoading(),
      const CategoriesError('Could not load the decks'),
    ],
  );

  test('totalWords adds all the categories', () {
    const state = CategoriesLoaded([numbers, numbers]);
    expect(state.totalWords, 20);
  });
}
