import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/audio/sound_player.dart';
import '../../lessons/domain/entities/category.dart';
import '../../lessons/domain/repositories/lesson_repository.dart';
import '../../progress/domain/repositories/progress_repository.dart';
import '../../progress/domain/usecases/save_result.dart';
import '../domain/usecases/make_quiz.dart';
import 'bloc/quiz_bloc.dart';
import 'pages/quiz_page.dart';

Route<void> quizRoute(BuildContext context, Category category) {
  final repository = context.read<LessonRepository>();
  final soundPlayer = context.read<SoundPlayer>();
  final progressRepository = context.read<ProgressRepository>();

  return MaterialPageRoute(
    builder: (_) => BlocProvider(
      create: (_) => QuizBloc(
        makeQuiz: MakeQuiz(repository),
        soundPlayer: soundPlayer,
        saveResult: SaveResult(progressRepository),
      )..add(QuizStarted(category.id)),
      child: QuizPage(category: category),
    ),
  );
}
