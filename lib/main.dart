import 'package:flutter/material.dart';

import 'app.dart';
import 'core/audio/sound_player.dart';
import 'features/lessons/data/datasources/lesson_local_data_source.dart';
import 'features/lessons/data/repositories/lesson_repository_impl.dart';

void main() {
  final repository = LessonRepositoryImpl(LessonLocalDataSource());
  final soundPlayer = AudioplayersSoundPlayer();

  runApp(LanguageLearningApp(
    repository: repository,
    soundPlayer: soundPlayer,
  ));
}
