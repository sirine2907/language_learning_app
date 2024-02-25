import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/word.dart';

class Flashcard extends StatelessWidget {
  final Word word;
  final int number;
  final bool isFlipped;
  final Color accent;

  const Flashcard({
    super.key,
    required this.word,
    required this.number,
    required this.isFlipped,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.line),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            offset: Offset(0, 8),
            blurRadius: 18,
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 26),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                number.toString().padLeft(2, '0'),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.muted,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Spacer(),
              Text(
                isFlipped ? '裏 · back' : '表 · front',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: accent,
                    ),
              ),
            ],
          ),
          Expanded(
            child: isFlipped ? _buildBack(context) : _buildFront(context),
          ),
        ],
      ),
    );
  }

  Widget _buildFront(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (word.hasImage) ...[
          Container(
            width: 180,
            height: 180,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.pictureBackground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Image.asset(word.image!, fit: BoxFit.contain),
          ),
          const SizedBox(height: 28),
        ],
        Text(
          word.kana,
          textAlign: TextAlign.center,
          // phrases are long so they get a smaller font
          style: word.hasImage ? textTheme.displaySmall : textTheme.headlineMedium,
        ),
        const SizedBox(height: 10),
        Text(
          word.romaji,
          textAlign: TextAlign.center,
          style: textTheme.titleMedium!.copyWith(
            color: AppColors.muted,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildBack(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '意味 · meaning',
          style: textTheme.labelLarge!.copyWith(color: AppColors.red),
        ),
        const SizedBox(height: 14),
        Text(
          word.english,
          textAlign: TextAlign.center,
          style: textTheme.displaySmall,
        ),
        const SizedBox(height: 22),
        Container(width: 40, height: 2, color: AppColors.line),
        const SizedBox(height: 22),
        Text(
          word.kana,
          textAlign: TextAlign.center,
          style: textTheme.titleMedium,
        ),
        const SizedBox(height: 4),
        Text(
          word.romaji,
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium!.copyWith(
            color: AppColors.muted,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
