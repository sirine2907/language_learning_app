import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/audio/sound_player.dart';
import '../../../progress/domain/usecases/save_result.dart';
import '../../domain/entities/question.dart';
import '../../domain/usecases/make_quiz.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final MakeQuiz makeQuiz;
  final SoundPlayer soundPlayer;
  final SaveResult saveResult;

  String _categoryId = '';
  DateTime _startedAt = DateTime.now();

  QuizBloc({
    required this.makeQuiz,
    required this.soundPlayer,
    required this.saveResult,
  }) : super(const QuizState()) {
    on<QuizStarted>(_onStarted);
    on<AnswerSelected>(_onAnswerSelected);
    on<NextQuestionPressed>(_onNext);
    on<QuizSoundPressed>(_onSound);
  }

  Future<void> _onStarted(QuizStarted event, Emitter<QuizState> emit) async {
    _categoryId = event.categoryId;
    emit(const QuizState(status: QuizStatus.loading));
    try {
      final questions = await makeQuiz(event.categoryId);
      _startedAt = DateTime.now();
      emit(QuizState(status: QuizStatus.ready, questions: questions));
    } catch (e) {
      emit(const QuizState(status: QuizStatus.error));
    }
  }

  void _onAnswerSelected(AnswerSelected event, Emitter<QuizState> emit) {
    // you can only answer once
    if (state.status != QuizStatus.ready || state.isAnswered) return;

    final isCorrect = event.answer == state.currentQuestion.answer;
    emit(state.copyWith(
      selected: event.answer,
      correctCount: isCorrect ? state.correctCount + 1 : state.correctCount,
    ));
  }

  Future<void> _onNext(NextQuestionPressed event, Emitter<QuizState> emit) async {
    if (state.status != QuizStatus.ready || !state.isAnswered) return;

    if (state.isLast) {
      await saveResult(_categoryId, score: state.score);
      emit(state.copyWith(
        status: QuizStatus.finished,
        timeSpent: DateTime.now().difference(_startedAt),
      ));
    } else {
      emit(state.copyWith(index: state.index + 1, clearSelected: true));
    }
  }

  Future<void> _onSound(QuizSoundPressed event, Emitter<QuizState> emit) async {
    if (state.status != QuizStatus.ready) return;
    await soundPlayer.play(state.currentQuestion.word.sound);
  }
}
