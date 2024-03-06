import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../progress/domain/entities/progress.dart';

// Mon to Sun of this week, a check on the days I practiced
class StreakRow extends StatelessWidget {
  final Progress progress;
  final DateTime today;

  const StreakRow({super.key, required this.progress, required this.today});

  static const _dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    // weekday is 1 for monday
    final monday = DateTime(today.year, today.month, today.day - (today.weekday - 1));

    return Row(
      children: [
        for (int i = 0; i < 7; i++)
          Expanded(
            child: _buildDay(
              context,
              _dayNames[i],
              DateTime(monday.year, monday.month, monday.day + i),
            ),
          ),
      ],
    );
  }

  Widget _buildDay(BuildContext context, String name, DateTime day) {
    final done = progress.practicedOn(day);
    final isToday = day.day == today.day && day.month == today.month;

    return Column(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: done ? AppColors.white : AppColors.glass,
            shape: BoxShape.circle,
            border: isToday && !done
                ? Border.all(color: AppColors.white, width: 2)
                : null,
          ),
          child: done
              ? const Icon(Icons.check_rounded, size: 20, color: AppColors.purple)
              : null,
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: AppColors.whiteMuted,
                fontWeight: isToday ? FontWeight.w800 : FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
