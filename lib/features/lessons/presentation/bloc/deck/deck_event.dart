part of 'deck_bloc.dart';

abstract class DeckEvent extends Equatable {
  const DeckEvent();

  @override
  List<Object?> get props => [];
}

class DeckStarted extends DeckEvent {
  final String categoryId;

  const DeckStarted(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class NextCardPressed extends DeckEvent {
  const NextCardPressed();
}

class PreviousCardPressed extends DeckEvent {
  const PreviousCardPressed();
}

class CardFlipped extends DeckEvent {
  const CardFlipped();
}

class SoundPressed extends DeckEvent {
  const SoundPressed();
}
