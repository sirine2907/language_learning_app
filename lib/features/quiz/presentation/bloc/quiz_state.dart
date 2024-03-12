part of 'quiz_bloc.dart';

enum QuizStatus { loading, ready, finished, error }

class QuizState extends Equatable {
  final QuizStatus status;
  final List<Question> questions;
  final int index;
  // null until I pick an answer
  final String? selected;
  final int correctCount;
  final Duration timeSpent;

  const QuizState({
    this.status = QuizStatus.loading,
    this.questions = const [],
    this.index = 0,
    this.selected,
    this.correctCount = 0,
    this.timeSpent = Duration.zero,
  });

  Question get currentQuestion => questions[index];

  bool get isAnswered => selected != null;

  bool get isLast => index == questions.length - 1;

  int get score {
    if (questions.isEmpty) return 0;
    return (correctCount * 100 / questions.length).round();
  }

  QuizState copyWith({
    QuizStatus? status,
    List<Question>? questions,
    int? index,
    String? selected,
    bool clearSelected = false,
    int? correctCount,
    Duration? timeSpent,
  }) {
    return QuizState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      index: index ?? this.index,
      selected: clearSelected ? null : (selected ?? this.selected),
      correctCount: correctCount ?? this.correctCount,
      timeSpent: timeSpent ?? this.timeSpent,
    );
  }

  @override
  List<Object?> get props =>
      [status, questions, index, selected, correctCount, timeSpent];
}
