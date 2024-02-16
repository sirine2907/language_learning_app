import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/audio/sound_player.dart';
import 'core/theme/app_theme.dart';
import 'features/lessons/domain/repositories/lesson_repository.dart';
import 'features/lessons/domain/usecases/get_categories.dart';
import 'features/lessons/presentation/bloc/categories/categories_bloc.dart';
import 'features/lessons/presentation/pages/home_page.dart';

class LanguageLearningApp extends StatelessWidget {
  final LessonRepository repository;
  final SoundPlayer soundPlayer;

  const LanguageLearningApp({
    super.key,
    required this.repository,
    required this.soundPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LessonRepository>.value(value: repository),
        RepositoryProvider<SoundPlayer>.value(value: soundPlayer),
      ],
      child: MaterialApp(
        title: 'Japanese Flashcards',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: BlocProvider(
          create: (_) => CategoriesBloc(
            getCategories: GetCategories(repository),
          )..add(const CategoriesRequested()),
          child: const HomePage(),
        ),
      ),
    );
  }
}
