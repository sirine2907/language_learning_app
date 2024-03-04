import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

// play button with some bars that look like a sound wave
class SoundPill extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const SoundPill({
    super.key,
    required this.onPressed,
    this.label = 'listen',
  });

  // heights of the bars, I just picked numbers that look nice
  static const _bars = <double>[
    8, 14, 22, 12, 26, 18, 10, 20, 28, 14, 8, 18, 24, 12, 16, 22, 10, 6,
    14, 20, 12, 8,
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.purpleSoft,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 6, 16, 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: AppColors.purple,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 12),
              for (final height in _bars)
                Container(
                  width: 3,
                  height: height,
                  margin: const EdgeInsets.symmetric(horizontal: 1.2),
                  decoration: BoxDecoration(
                    color: AppColors.purple,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              const SizedBox(width: 12),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColors.purple,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
