import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/audio/sound_player.dart';
import 'features/lessons/data/datasources/lesson_local_data_source.dart';
import 'features/lessons/data/repositories/lesson_repository_impl.dart';
import 'features/progress/data/datasources/progress_local_data_source.dart';
import 'features/progress/data/repositories/progress_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final repository = LessonRepositoryImpl(LessonLocalDataSource());
  final progressRepository = ProgressRepositoryImpl(
    ProgressLocalDataSource(prefs),
  );
  final soundPlayer = AudioplayersSoundPlayer();

  runApp(LanguageLearningApp(
    repository: repository,
    progressRepository: progressRepository,
    soundPlayer: soundPlayer,
  ));
}
