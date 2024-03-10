part of 'deck_bloc.dart';

enum DeckStatus { loading, ready, finished, error }

class DeckState extends Equatable {
  final DeckStatus status;
  final List<Word> words;
  final int index;
  final bool isFlipped;
  // only set when the deck is finished
  final Duration timeSpent;

  const DeckState({
    this.status = DeckStatus.loading,
    this.words = const [],
    this.index = 0,
    this.isFlipped = false,
    this.timeSpent = Duration.zero,
  });

  Word get currentWord => words[index];

  bool get isFirst => index == 0;

  bool get isLast => index == words.length - 1;

  DeckState copyWith({
    DeckStatus? status,
    List<Word>? words,
    int? index,
    bool? isFlipped,
    Duration? timeSpent,
  }) {
    return DeckState(
      status: status ?? this.status,
      words: words ?? this.words,
      index: index ?? this.index,
      isFlipped: isFlipped ?? this.isFlipped,
      timeSpent: timeSpent ?? this.timeSpent,
    );
  }

  @override
  List<Object?> get props => [status, words, index, isFlipped, timeSpent];
}
