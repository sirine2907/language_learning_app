import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:language_learning_app/core/audio/sound_player.dart';
import 'package:language_learning_app/features/lessons/domain/entities/word.dart';
import 'package:language_learning_app/features/lessons/domain/repositories/lesson_repository.dart';
import 'package:language_learning_app/features/lessons/domain/usecases/get_words.dart';
import 'package:language_learning_app/features/lessons/presentation/bloc/deck/deck_bloc.dart';
import 'package:language_learning_app/features/progress/domain/usecases/save_result.dart';
import 'package:mocktail/mocktail.dart';

class MockLessonRepository extends Mock implements LessonRepository {}

class MockSoundPlayer extends Mock implements SoundPlayer {}

class MockSaveResult extends Mock implements SaveResult {}

void main() {
  late MockLessonRepository repository;
  late MockSoundPlayer soundPlayer;
  late MockSaveResult saveResult;

  const words = [
    Word(romaji: 'ichi', kana: 'いち', english: 'one', sound: 'one.mp3'),
    Word(romaji: 'ni', kana: 'に', english: 'two', sound: 'two.mp3'),
  ];

  const ready = DeckState(status: DeckStatus.ready, words: words);

  setUp(() {
    repository = MockLessonRepository();
    soundPlayer = MockSoundPlayer();
    saveResult = MockSaveResult();
    when(() => soundPlayer.play(any())).thenAnswer((_) async {});
    when(() => saveResult(any(), score: any(named: 'score')))
        .thenAnswer((_) async {});
  });

  DeckBloc buildBloc() {
    return DeckBloc(
      getWords: GetWords(repository),
      soundPlayer: soundPlayer,
      saveResult: saveResult,
    );
  }

  blocTest<DeckBloc, DeckState>(
    'loads the words of the category',
    setUp: () {
      when(() => repository.getWords('numbers')).thenAnswer((_) async => words);
    },
    build: buildBloc,
    act: (bloc) => bloc.add(const DeckStarted('numbers')),
    expect: () => [const DeckState(status: DeckStatus.loading), ready],
  );

  blocTest<DeckBloc, DeckState>(
    'shows error when the words can not load',
    setUp: () {
      when(() => repository.getWords('x')).thenThrow(Exception('no'));
    },
    build: buildBloc,
    act: (bloc) => bloc.add(const DeckStarted('x')),
    expect: () => [
      const DeckState(status: DeckStatus.loading),
      const DeckState(status: DeckStatus.error),
    ],
  );

  blocTest<DeckBloc, DeckState>(
    'next goes to the next card and turns it back to the front',
    build: buildBloc,
    seed: () => ready.copyWith(isFlipped: true),
    act: (bloc) => bloc.add(const NextCardPressed()),
    expect: () => [ready.copyWith(index: 1, isFlipped: false)],
  );

  blocTest<DeckBloc, DeckState>(
    'next on the last card finishes the deck and saves the day',
    setUp: () {
      when(() => repository.getWords('numbers')).thenAnswer((_) async => words);
    },
    build: buildBloc,
    act: (bloc) async {
      bloc.add(const DeckStarted('numbers'));
      await Future.delayed(Duration.zero);
      bloc
        ..add(const NextCardPressed())
        ..add(const NextCardPressed());
    },
    skip: 3,
    expect: () => [
      isA<DeckState>().having((s) => s.status, 'status', DeckStatus.finished),
    ],
    verify: (_) {
      verify(() => saveResult('numbers')).called(1);
    },
  );

  blocTest<DeckBloc, DeckState>(
    'previous does nothing on the first card',
    build: buildBloc,
    seed: () => ready,
    act: (bloc) => bloc.add(const PreviousCardPressed()),
    expect: () => [],
  );

  blocTest<DeckBloc, DeckState>(
    'previous goes back one card',
    build: buildBloc,
    seed: () => ready.copyWith(index: 1),
    act: (bloc) => bloc.add(const PreviousCardPressed()),
    expect: () => [ready],
  );

  blocTest<DeckBloc, DeckState>(
    'flip shows the back then the front again',
    build: buildBloc,
    seed: () => ready,
    act: (bloc) => bloc
      ..add(const CardFlipped())
      ..add(const CardFlipped()),
    expect: () => [ready.copyWith(isFlipped: true), ready],
  );

  blocTest<DeckBloc, DeckState>(
    'sound plays the current word',
    build: buildBloc,
    seed: () => ready.copyWith(index: 1),
    act: (bloc) => bloc.add(const SoundPressed()),
    verify: (_) {
      verify(() => soundPlayer.play('two.mp3')).called(1);
    },
  );
}
