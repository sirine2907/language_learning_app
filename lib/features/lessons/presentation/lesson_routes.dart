import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/audio/sound_player.dart';
import '../../progress/presentation/bloc/progress_bloc.dart';
import '../domain/entities/category.dart';
import '../domain/repositories/lesson_repository.dart';
import '../domain/usecases/get_words.dart';
import 'bloc/deck/deck_bloc.dart';
import 'pages/flashcards_page.dart';

Future<void> openLesson(BuildContext context, Category category) async {
  // read it before the await, the context can be gone after
  final progressBloc = context.read<ProgressBloc>();

  await Navigator.push(context, flashcardsRoute(context, category));

  // something may be finished, load the streak and scores again
  progressBloc.add(const ProgressRequested());
}

Route<void> flashcardsRoute(BuildContext context, Category category) {
  final repository = context.read<LessonRepository>();
  final soundPlayer = context.read<SoundPlayer>();

  return MaterialPageRoute(
    builder: (_) => BlocProvider(
      create: (_) => DeckBloc(
        getWords: GetWords(repository),
        soundPlayer: soundPlayer,
      )..add(DeckStarted(category.id)),
      child: FlashcardsPage(category: category),
    ),
  );
}
