import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/category.dart';

// small white card in "Your Progress", the percent is the best quiz score
class ProgressCard extends StatelessWidget {
  final Category category;
  final int percent;
  final VoidCallback onTap;

  const ProgressCard({
    super.key,
    required this.category,
    required this.percent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          width: 150,
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.level,
                style: textTheme.labelSmall!.copyWith(color: AppColors.muted),
              ),
              const SizedBox(height: 2),
              Text(
                category.stamp,
                style: textTheme.displaySmall!.copyWith(
                  fontSize: 30,
                  height: 1.3,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      category.title,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    '$percent%',
                    style: textTheme.labelSmall!.copyWith(
                      color: AppColors.muted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: percent / 100,
                  minHeight: 5,
                  color: AppColors.purple,
                  backgroundColor: AppColors.purpleSoft,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
