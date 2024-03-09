import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/sound_pill.dart';
import '../../domain/entities/word.dart';

class Flashcard extends StatelessWidget {
  final Word word;
  final bool isFlipped;
  final VoidCallback onSound;

  const Flashcard({
    super.key,
    required this.word,
    required this.isFlipped,
    required this.onSound,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isFlipped ? 'Meaning' : 'Tap the card to see the meaning',
            style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700),
          ),
          Expanded(
            child: isFlipped ? _buildBack(context) : _buildFront(context),
          ),
          Center(child: SoundPill(onPressed: onSound)),
        ],
      ),
    );
  }

  Widget _buildFront(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (word.hasImage) ...[
              Container(
                width: 160,
                height: 160,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.purpleSoft,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Image.asset(word.image!, fit: BoxFit.contain),
              ),
              const SizedBox(height: 24),
            ],
            Text(
              word.kana,
              textAlign: TextAlign.center,
              // phrases are long so they get a smaller font
              style: word.hasImage
                  ? textTheme.displaySmall!.copyWith(fontSize: 34)
                  : textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              word.romaji,
              textAlign: TextAlign.center,
              style: textTheme.titleSmall!.copyWith(color: AppColors.muted),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBack(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.purpleSoft,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '意味 · meaning',
                style: textTheme.labelMedium!.copyWith(
                  color: AppColors.purple,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              word.english,
              textAlign: TextAlign.center,
              style: textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              word.kana,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 2),
            Text(
              word.romaji,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium!.copyWith(color: AppColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}
