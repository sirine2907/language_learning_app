import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/category.dart';

// A category drawn like a small pile of cards.
// The two cards behind are only decoration.
class CategoryDeckCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryDeckCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(category.color);
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Stack(
        children: [
          Positioned.fill(
            child: Transform.rotate(
              angle: 0.035,
              child: _paper(),
            ),
          ),
          Positioned.fill(
            child: Transform.rotate(
              angle: -0.02,
              child: _paper(),
            ),
          ),
          Material(
            color: AppColors.card,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: AppColors.line),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 18, 14, 18),
                child: Row(
                  children: [
                    _Stamp(text: category.stamp, color: color),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.title,
                            style: textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            category.japaneseTitle,
                            style: textTheme.bodyMedium!.copyWith(
                              color: AppColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${category.wordCount}',
                          style: textTheme.headlineSmall!.copyWith(
                            color: color,
                            height: 1,
                          ),
                        ),
                        Text(
                          'cards',
                          style: textTheme.labelSmall!.copyWith(
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.chevron_right, color: AppColors.muted),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paper() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.line),
      ),
    );
  }
}

// round stamp with one kanji, like a hanko
class _Stamp extends StatelessWidget {
  final String text;
  final Color color;

  const _Stamp({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2.5),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: color,
              height: 1.1,
            ),
      ),
    );
  }
}
