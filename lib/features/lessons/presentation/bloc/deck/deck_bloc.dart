import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/audio/sound_player.dart';
import '../../../domain/entities/word.dart';
import '../../../domain/usecases/get_words.dart';

part 'deck_event.dart';
part 'deck_state.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState> {
  final GetWords getWords;
  final SoundPlayer soundPlayer;

  DeckBloc({required this.getWords, required this.soundPlayer})
      : super(const DeckState()) {
    on<DeckStarted>(_onStarted);
    on<NextCardPressed>(_onNext);
    on<PreviousCardPressed>(_onPrevious);
    on<CardFlipped>(_onFlipped);
    on<SoundPressed>(_onSound);
    on<DeckRestarted>(_onRestarted);
  }

  Future<void> _onStarted(DeckStarted event, Emitter<DeckState> emit) async {
    emit(const DeckState(status: DeckStatus.loading));
    try {
      final words = await getWords(event.categoryId);
      emit(DeckState(status: DeckStatus.ready, words: words));
    } catch (e) {
      emit(const DeckState(status: DeckStatus.error));
    }
  }

  void _onNext(NextCardPressed event, Emitter<DeckState> emit) {
    if (state.status != DeckStatus.ready) return;

    if (state.isLast) {
      // went through every card
      emit(state.copyWith(status: DeckStatus.finished));
    } else {
      emit(state.copyWith(index: state.index + 1, isFlipped: false));
    }
  }

  void _onPrevious(PreviousCardPressed event, Emitter<DeckState> emit) {
    if (state.status != DeckStatus.ready || state.isFirst) return;
    emit(state.copyWith(index: state.index - 1, isFlipped: false));
  }

  void _onFlipped(CardFlipped event, Emitter<DeckState> emit) {
    if (state.status != DeckStatus.ready) return;
    emit(state.copyWith(isFlipped: !state.isFlipped));
  }

  Future<void> _onSound(SoundPressed event, Emitter<DeckState> emit) async {
    if (state.status != DeckStatus.ready) return;
    await soundPlayer.play(state.currentWord.sound);
  }

  void _onRestarted(DeckRestarted event, Emitter<DeckState> emit) {
    emit(state.copyWith(status: DeckStatus.ready, index: 0, isFlipped: false));
  }
}
