import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/audio/sound_player.dart';
import '../../progress/domain/repositories/progress_repository.dart';
import '../../progress/domain/usecases/save_result.dart';
import '../domain/entities/category.dart';
import '../domain/repositories/lesson_repository.dart';
import '../domain/usecases/get_words.dart';
import 'bloc/deck/deck_bloc.dart';
import 'pages/flashcards_page.dart';

void openLesson(BuildContext context, Category category) {
  Navigator.push(context, flashcardsRoute(context, category));
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
