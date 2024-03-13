import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/category.dart';

enum LessonMode { flashcards, quiz }

// bottom sheet that asks: study the cards or take the quiz?
Future<LessonMode?> showChooseModeSheet(BuildContext context, Category category) {
  return showModalBottomSheet<LessonMode>(
    context: context,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (sheetContext) {
      final textTheme = Theme.of(sheetContext).textTheme;

      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.title,
                style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w800),
              ),
              Text(
                '${category.japaneseTitle} · ${category.wordCount} words',
                style: textTheme.bodySmall!.copyWith(color: AppColors.muted),
              ),
              const SizedBox(height: 18),
              _ModeOption(
                icon: Icons.style_rounded,
                title: 'Study the cards',
                description: 'See every word, flip it and listen',
                onTap: () => Navigator.pop(sheetContext, LessonMode.flashcards),
              ),
              const SizedBox(height: 10),
              _ModeOption(
                icon: Icons.headphones_rounded,
                title: 'Take the quiz',
                description: 'Listen and pick the right meaning',
                onTap: () => Navigator.pop(sheetContext, LessonMode.quiz),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _ModeOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _ModeOption({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: AppColors.purpleSoft,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: AppColors.purple,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.white),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      description,
                      style: textTheme.bodySmall!.copyWith(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.purple),
            ],
          ),
        ),
      ),
    );
  }
}
