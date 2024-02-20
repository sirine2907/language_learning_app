import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/category.dart';

class DeckFinishedView extends StatelessWidget {
  final Category category;
  final VoidCallback onRestart;

  const DeckFinishedView({
    super.key,
    required this.category,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final accent = Color(category.color);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.red, width: 3),
              ),
              child: Text(
                '済',
                style: textTheme.displaySmall!.copyWith(color: AppColors.red),
              ),
            ),
            const SizedBox(height: 28),
            Text('お疲れさま！', style: textTheme.headlineMedium),
            const SizedBox(height: 4),
            Text(
              'otsukaresama · good job',
              style: textTheme.bodyMedium!.copyWith(
                color: AppColors.muted,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'You went through all ${category.wordCount} cards '
              'of ${category.title}.',
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: onRestart,
              style: FilledButton.styleFrom(
                backgroundColor: accent,
                minimumSize: const Size(220, 50),
              ),
              child: const Text('Go again'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(foregroundColor: AppColors.ink),
              child: const Text('Back to decks'),
            ),
          ],
        ),
      ),
    );
  }
}
