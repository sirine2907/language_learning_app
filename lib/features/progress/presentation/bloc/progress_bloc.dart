import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/progress.dart';
import '../../domain/usecases/get_progress.dart';

part 'progress_event.dart';
part 'progress_state.dart';

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  final GetProgress getProgress;

  ProgressBloc({required this.getProgress}) : super(const ProgressState()) {
    on<ProgressRequested>(_onRequested);
  }

  Future<void> _onRequested(
    ProgressRequested event,
    Emitter<ProgressState> emit,
  ) async {
    try {
      final progress = await getProgress();
      emit(ProgressState(progress: progress));
    } catch (e) {
      // if it fails the home page just shows 0% everywhere
      emit(const ProgressState());
    }
  }
}
