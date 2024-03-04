import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'glass_icon_button.dart';

// close button + progress bar + "3/10", top of the flashcards and the quiz
class LessonTopBar extends StatelessWidget {
  final double progress;
  final String counter;
  final VoidCallback onClose;

  const LessonTopBar({
    super.key,
    required this.progress,
    required this.counter,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          GlassIconButton(
            icon: Icons.close,
            tooltip: 'Close',
            onPressed: onClose,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                color: AppColors.white,
                backgroundColor: AppColors.glass,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.glass,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              counter,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
