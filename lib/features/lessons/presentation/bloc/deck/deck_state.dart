part of 'deck_bloc.dart';

enum DeckStatus { loading, ready, finished, error }

class DeckState extends Equatable {
  final DeckStatus status;
  final List<Word> words;
  final int index;
  final bool isFlipped;

  const DeckState({
    this.status = DeckStatus.loading,
    this.words = const [],
    this.index = 0,
    this.isFlipped = false,
  });

  Word get currentWord => words[index];

  bool get isFirst => index == 0;

  bool get isLast => index == words.length - 1;

  DeckState copyWith({
    DeckStatus? status,
    List<Word>? words,
    int? index,
    bool? isFlipped,
  }) {
    return DeckState(
      status: status ?? this.status,
      words: words ?? this.words,
      index: index ?? this.index,
      isFlipped: isFlipped ?? this.isFlipped,
    );
  }

  @override
  List<Object?> get props => [status, words, index, isFlipped];
}
