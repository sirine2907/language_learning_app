import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/audio/sound_player.dart';
import 'core/theme/app_theme.dart';
import 'features/lessons/domain/repositories/lesson_repository.dart';
import 'features/lessons/domain/usecases/get_categories.dart';
import 'features/lessons/presentation/bloc/categories/categories_bloc.dart';
import 'features/lessons/presentation/pages/home_page.dart';
import 'features/progress/domain/repositories/progress_repository.dart';
import 'features/progress/domain/usecases/get_progress.dart';
import 'features/progress/presentation/bloc/progress_bloc.dart';

class LanguageLearningApp extends StatelessWidget {
  final LessonRepository repository;
  final ProgressRepository progressRepository;
  final SoundPlayer soundPlayer;

  const LanguageLearningApp({
    super.key,
    required this.repository,
    required this.progressRepository,
    required this.soundPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LessonRepository>.value(value: repository),
        RepositoryProvider<ProgressRepository>.value(value: progressRepository),
        RepositoryProvider<SoundPlayer>.value(value: soundPlayer),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => CategoriesBloc(
              getCategories: GetCategories(repository),
            )..add(const CategoriesRequested()),
          ),
          BlocProvider(
            create: (_) => ProgressBloc(
              getProgress: GetProgress(progressRepository),
            )..add(const ProgressRequested()),
          ),
        ],
        child: MaterialApp(
          title: 'Japanese Flashcards',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          home: const HomePage(),
        ),
      ),
    );
  }
}
