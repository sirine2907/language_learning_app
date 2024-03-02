part of 'progress_bloc.dart';

class ProgressState extends Equatable {
  final Progress progress;

  const ProgressState({this.progress = const Progress()});

  @override
  List<Object?> get props => [progress];
}
