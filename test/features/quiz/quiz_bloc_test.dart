import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:language_learning_app/core/audio/sound_player.dart';
import 'package:language_learning_app/features/lessons/domain/entities/word.dart';
import 'package:language_learning_app/features/progress/domain/usecases/save_result.dart';
import 'package:language_learning_app/features/quiz/domain/entities/question.dart';
import 'package:language_learning_app/features/quiz/domain/usecases/make_quiz.dart';
import 'package:language_learning_app/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockMakeQuiz extends Mock implements MakeQuiz {}

class MockSoundPlayer extends Mock implements SoundPlayer {}

class MockSaveResult extends Mock implements SaveResult {}

void main() {
  late MockMakeQuiz makeQuiz;
  late MockSoundPlayer soundPlayer;
  late MockSaveResult saveResult;

  const questions = [
    Question(
      word: Word(romaji: 'aka', kana: '赤', english: 'red', sound: 'red.wav'),
      options: ['red', 'blue', 'green', 'black'],
    ),
    Question(
      word: Word(romaji: 'kuro', kana: '黒', english: 'black', sound: 'black.wav'),
      options: ['white', 'black', 'red', 'gray'],
    ),
  ];

  const ready = QuizState(status: QuizStatus.ready, questions: questions);

  setUp(() {
    makeQuiz = MockMakeQuiz();
    soundPlayer = MockSoundPlayer();
    saveResult = MockSaveResult();
    when(() => makeQuiz('colors')).thenAnswer((_) async => questions);
    when(() => soundPlayer.play(any())).thenAnswer((_) async {});
    when(() => saveResult(any(), score: any(named: 'score')))
        .thenAnswer((_) async {});
  });

  QuizBloc buildBloc() {
    return QuizBloc(
      makeQuiz: makeQuiz,
      soundPlayer: soundPlayer,
      saveResult: saveResult,
    );
  }

  blocTest<QuizBloc, QuizState>(
    'loads the questions',
    build: buildBloc,
    act: (bloc) => bloc.add(const QuizStarted('colors')),
    expect: () => [const QuizState(status: QuizStatus.loading), ready],
  );

  blocTest<QuizBloc, QuizState>(
    'right answer adds one to the score',
    build: buildBloc,
    seed: () => ready,
    act: (bloc) => bloc.add(const AnswerSelected('red')),
    expect: () => [ready.copyWith(selected: 'red', correctCount: 1)],
  );

  blocTest<QuizBloc, QuizState>(
    'wrong answer does not add to the score',
    build: buildBloc,
    seed: () => ready,
    act: (bloc) => bloc.add(const AnswerSelected('blue')),
    expect: () => [ready.copyWith(selected: 'blue')],
  );

  blocTest<QuizBloc, QuizState>(
    'can not answer the same question twice',
    build: buildBloc,
    seed: () => ready,
    act: (bloc) => bloc
      ..add(const AnswerSelected('blue'))
      ..add(const AnswerSelected('red')),
    expect: () => [ready.copyWith(selected: 'blue')],
  );

  blocTest<QuizBloc, QuizState>(
    'next does nothing before answering',
    build: buildBloc,
    seed: () => ready,
    act: (bloc) => bloc.add(const NextQuestionPressed()),
    expect: () => [],
  );

  blocTest<QuizBloc, QuizState>(
    'next goes to the next question and clears the answer',
    build: buildBloc,
    seed: () => ready.copyWith(selected: 'red', correctCount: 1),
    act: (bloc) => bloc.add(const NextQuestionPressed()),
    expect: () => [ready.copyWith(index: 1, correctCount: 1)],
  );

  blocTest<QuizBloc, QuizState>(
    'finishing the quiz saves the score',
    build: buildBloc,
    act: (bloc) async {
      bloc.add(const QuizStarted('colors'));
      await Future.delayed(Duration.zero);
      bloc
        ..add(const AnswerSelected('red'))
        ..add(const NextQuestionPressed())
        ..add(const AnswerSelected('white'))
        ..add(const NextQuestionPressed());
    },
    skip: 5,
    expect: () => [
      isA<QuizState>()
          .having((s) => s.status, 'status', QuizStatus.finished)
          .having((s) => s.score, 'score', 50),
    ],
    verify: (_) {
      verify(() => saveResult('colors', score: 50)).called(1);
    },
  );

  blocTest<QuizBloc, QuizState>(
    'sound plays the word of the question',
    build: buildBloc,
    seed: () => ready.copyWith(index: 1),
    act: (bloc) => bloc.add(const QuizSoundPressed()),
    verify: (_) {
      verify(() => soundPlayer.play('black.wav')).called(1);
    },
  );
}
