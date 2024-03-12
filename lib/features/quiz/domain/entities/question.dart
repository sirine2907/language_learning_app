import 'package:equatable/equatable.dart';

import '../../../lessons/domain/entities/word.dart';

class Question extends Equatable {
  final Word word;
  // 4 english meanings, one of them is the right one
  final List<String> options;

  const Question({required this.word, required this.options});

  String get answer => word.english;

  @override
  List<Object?> get props => [word, options];
}
