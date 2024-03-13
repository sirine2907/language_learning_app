import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/audio/sound_player.dart';
import '../../progress/domain/repositories/progress_repository.dart';
import '../../progress/domain/usecases/save_result.dart';
import '../../quiz/presentation/quiz_route.dart';
import '../domain/entities/category.dart';
import '../domain/repositories/lesson_repository.dart';
import '../domain/usecases/get_words.dart';
import 'bloc/deck/deck_bloc.dart';
import 'pages/flashcards_page.dart';
import 'widgets/choose_mode_sheet.dart';

Future<void> openLesson(BuildContext context, Category category) async {
  final mode = await showChooseModeSheet(context, category);
  if (mode == null || !context.mounted) return;

  if (mode == LessonMode.flashcards) {
    Navigator.push(context, flashcardsRoute(context, category));
  } else {
    Navigator.push(context, quizRoute(context, category));
  }
}

Route<void> flashcardsRoute(BuildContext context, Category category) {
  final repository = context.read<LessonRepository>();
  final soundPlayer = context.read<SoundPlayer>();
  final progressRepository = context.read<ProgressRepository>();

  return MaterialPageRoute(
    builder: (_) => BlocProvider(
      create: (_) => DeckBloc(
        getWords: GetWords(repository),
        soundPlayer: soundPlayer,
        saveResult: SaveResult(progressRepository),
      )..add(DeckStarted(category.id)),
      child: FlashcardsPage(category: category),
    ),
  );
}
