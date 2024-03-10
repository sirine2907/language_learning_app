import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/audio/sound_player.dart';
import '../../../../progress/domain/usecases/save_result.dart';
import '../../../domain/entities/word.dart';
import '../../../domain/usecases/get_words.dart';

part 'deck_event.dart';
part 'deck_state.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState> {
  final GetWords getWords;
  final SoundPlayer soundPlayer;
  final SaveResult saveResult;

  String _categoryId = '';
  DateTime _startedAt = DateTime.now();

  DeckBloc({
    required this.getWords,
    required this.soundPlayer,
    required this.saveResult,
  }) : super(const DeckState()) {
    on<DeckStarted>(_onStarted);
    on<NextCardPressed>(_onNext);
    on<PreviousCardPressed>(_onPrevious);
    on<CardFlipped>(_onFlipped);
    on<SoundPressed>(_onSound);
  }

  Future<void> _onStarted(DeckStarted event, Emitter<DeckState> emit) async {
    _categoryId = event.categoryId;
    emit(const DeckState(status: DeckStatus.loading));
    try {
      final words = await getWords(event.categoryId);
      _startedAt = DateTime.now();
      emit(DeckState(status: DeckStatus.ready, words: words));
    } catch (e) {
      emit(const DeckState(status: DeckStatus.error));
    }
  }

  Future<void> _onNext(NextCardPressed event, Emitter<DeckState> emit) async {
    if (state.status != DeckStatus.ready) return;

    if (state.isLast) {
      // went through every card, this counts for the streak
      await saveResult(_categoryId);
      emit(state.copyWith(
        status: DeckStatus.finished,
        timeSpent: DateTime.now().difference(_startedAt),
      ));
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
}
