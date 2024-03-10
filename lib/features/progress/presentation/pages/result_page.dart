import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/big_button.dart';
import '../../../../core/widgets/glass_icon_button.dart';
import '../../../../core/widgets/purple_background.dart';

class ResultStat {
  final IconData icon;
  final String label;
  final String value;

  const ResultStat(this.icon, this.label, this.value);
}

// screen after finishing the flashcards or the quiz
class ResultPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<ResultStat> stats;
  final String conclusion;
  final VoidCallback onTryAgain;

  const ResultPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.stats,
    required this.conclusion,
    required this.onTryAgain,
  });

  static String formatTime(Duration time) {
    if (time.inSeconds < 60) {
      return '${time.inSeconds} secs';
    }
    final minutes = (time.inSeconds / 60).round();
    return minutes == 1 ? '1 min' : '$minutes mins';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: PurpleBackground(
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GlassIconButton(
                          icon: Icons.close,
                          tooltip: 'Close',
                          onPressed: () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: Text(
                            'Lesson Completed!',
                            textAlign: TextAlign.center,
                            style: textTheme.titleMedium!.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        // same size as the close button so the title is centered
                        const SizedBox(width: 40),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.glass,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.glass),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subtitle,
                            style: textTheme.labelMedium!.copyWith(
                              color: AppColors.whiteMuted,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            title,
                            style: textTheme.titleLarge!.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              for (final stat in stats)
                                Expanded(child: _buildStat(context, stat)),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(height: 1, color: AppColors.glass),
                          const SizedBox(height: 18),
                          Text(
                            'Conclusions',
                            style: textTheme.titleSmall!.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            conclusion,
                            style: textTheme.bodyMedium!.copyWith(
                              color: AppColors.whiteText,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    BigButton(
                      text: 'Try again',
                      filled: false,
                      onPressed: onTryAgain,
                    ),
                    const SizedBox(height: 12),
                    BigButton(
                      text: 'Back to lessons',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStat(BuildContext context, ResultStat stat) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(stat.icon, size: 14, color: AppColors.whiteMuted),
            const SizedBox(width: 4),
            Text(
              stat.label,
              style: textTheme.labelSmall!.copyWith(color: AppColors.whiteMuted),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          stat.value,
          style: textTheme.titleMedium!.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
