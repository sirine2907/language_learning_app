import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/category.dart';

// one row in the white list on the home page
class LessonTile extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const LessonTile({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = Color(category.color);
    // about 30 seconds per card
    final minutes = (category.wordCount / 2).ceil();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color.withAlpha(36),
                shape: BoxShape.circle,
              ),
              child: Text(
                category.stamp,
                style: textTheme.headlineSmall!.copyWith(
                  color: color,
                  fontSize: 20,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          category.title,
                          style: textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        category.level,
                        style: textTheme.labelSmall!.copyWith(
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.schedule, size: 14, color: AppColors.muted),
                      const SizedBox(width: 4),
                      Text(
                        '$minutes mins',
                        style: textTheme.labelSmall!.copyWith(
                          color: AppColors.muted,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Icon(Icons.help_outline, size: 14, color: AppColors.muted),
                      const SizedBox(width: 4),
                      Text(
                        '${category.wordCount} Questions',
                        style: textTheme.labelSmall!.copyWith(
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
