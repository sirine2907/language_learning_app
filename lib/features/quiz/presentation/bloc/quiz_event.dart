part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object?> get props => [];
}

class QuizStarted extends QuizEvent {
  final String categoryId;

  const QuizStarted(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class AnswerSelected extends QuizEvent {
  final String answer;

  const AnswerSelected(this.answer);

  @override
  List<Object?> get props => [answer];
}

class NextQuestionPressed extends QuizEvent {
  const NextQuestionPressed();
}

class QuizSoundPressed extends QuizEvent {
  const QuizSoundPressed();
}
