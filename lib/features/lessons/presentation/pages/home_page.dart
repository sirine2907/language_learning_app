import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/purple_background.dart';
import '../../../progress/domain/entities/progress.dart';
import '../../../progress/presentation/bloc/progress_bloc.dart';
import '../../domain/entities/category.dart';
import '../bloc/categories/categories_bloc.dart';
import '../lesson_routes.dart';
import '../widgets/lesson_tile.dart';
import '../widgets/progress_card.dart';
import '../widgets/streak_row.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PurpleBackground(
        child: SafeArea(
          bottom: false,
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, categoriesState) {
              if (categoriesState is CategoriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.white),
                );
              }

              if (categoriesState is CategoriesError) {
                return Center(
                  child: Text(
                    categoriesState.message,
                    style: const TextStyle(color: AppColors.white),
                  ),
                );
              }

              final categories = (categoriesState as CategoriesLoaded).categories;

              return BlocBuilder<ProgressBloc, ProgressState>(
                builder: (context, progressState) {
                  return _buildContent(context, categories, progressState.progress);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<Category> categories,
    Progress progress,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final today = DateTime.now();
    final streak = progress.streak(today);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back,',
                      style: textTheme.bodySmall!.copyWith(
                        color: AppColors.whiteMuted,
                      ),
                    ),
                    Text(
                      'Let\'s learn Japanese',
                      style: textTheme.titleLarge!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              _StreakBadge(days: streak),
            ],
          ),
        ),
        const SizedBox(height: 22),
        _sectionTitle(context, 'Daily Streaks'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: StreakRow(progress: progress, today: today),
        ),
        const SizedBox(height: 22),
        _sectionTitle(context, 'Your Progress'),
        SizedBox(
          height: 136,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final category = categories[index];
              return ProgressCard(
                category: category,
                percent: progress.scoreFor(category.id),
                onTap: () => openLesson(context, category),
              );
            },
          ),
        ),
        const SizedBox(height: 22),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.line,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    'Lessons',
                    style: textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                for (final category in categories)
                  LessonTile(
                    category: category,
                    onTap: () => openLesson(context, category),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _StreakBadge extends StatelessWidget {
  final int days;

  const _StreakBadge({required this.days});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 14, 8),
      decoration: BoxDecoration(
        color: AppColors.glass,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.local_fire_department_rounded,
            color: AppColors.white,
            size: 20,
          ),
          const SizedBox(width: 4),
          Text(
            '$days',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}
