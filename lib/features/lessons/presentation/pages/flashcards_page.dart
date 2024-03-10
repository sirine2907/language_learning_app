import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/big_button.dart';
import '../../../../core/widgets/glass_icon_button.dart';
import '../../../../core/widgets/lesson_top_bar.dart';
import '../../../../core/widgets/purple_background.dart';
import '../../../progress/presentation/bloc/progress_bloc.dart';
import '../../../progress/presentation/pages/result_page.dart';
import '../../domain/entities/category.dart';
import '../bloc/deck/deck_bloc.dart';
import '../lesson_routes.dart';
import '../widgets/flashcard.dart';

class FlashcardsPage extends StatelessWidget {
  final Category category;

  const FlashcardsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PurpleBackground(
        child: SafeArea(
          child: BlocConsumer<DeckBloc, DeckState>(
            listener: (context, state) {
              if (state.status == DeckStatus.finished) {
                _showResult(context, state);
              }
            },
            builder: (context, state) {
              if (state.status == DeckStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.white),
                );
              }

              if (state.status == DeckStatus.error) {
                return const Center(
                  child: Text(
                    'Could not load this deck',
                    style: TextStyle(color: AppColors.white),
                  ),
                );
              }

              if (state.status == DeckStatus.finished) {
                // the listener opens the result page
                return const SizedBox();
              }

              return _buildCards(context, state);
            },
          ),
        ),
      ),
    );
  }

  void _showResult(BuildContext context, DeckState state) {
    // the day is saved, so the home page needs the new streak
    context.read<ProgressBloc>().add(const ProgressRequested());

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (resultContext) => ResultPage(
          title: '${category.title} Cards',
          subtitle: 'Japanese · Flashcards',
          stats: [
            ResultStat(Icons.style_outlined, 'Cards', '${state.words.length}'),
            ResultStat(
              Icons.schedule,
              'Time',
              ResultPage.formatTime(state.timeSpent),
            ),
            const ResultStat(Icons.local_fire_department_outlined, 'Streak', '+1 day'),
          ],
          conclusion: 'You went through all ${state.words.length} cards of '
              '${category.title}. Now take the quiz to see how many words you '
              'really remember!',
          onTryAgain: () => Navigator.pushReplacement(
            resultContext,
            flashcardsRoute(resultContext, category),
          ),
        ),
      ),
    );
  }

  Widget _buildCards(BuildContext context, DeckState state) {
    final bloc = context.read<DeckBloc>();

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          children: [
            LessonTopBar(
              progress: (state.index + 1) / state.words.length,
              counter: '${state.index + 1}/${state.words.length}',
              onClose: () => Navigator.pop(context),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              child: Row(
                children: [
                  Text(
                    category.title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    category.japaneseTitle,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.whiteMuted,
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
                child: GestureDetector(
                  onTap: () => bloc.add(const CardFlipped()),
                  onHorizontalDragEnd: (details) {
                    final speed = details.primaryVelocity ?? 0;
                    if (speed < -200) {
                      bloc.add(const NextCardPressed());
                    } else if (speed > 200) {
                      bloc.add(const PreviousCardPressed());
                    }
                  },
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Flashcard(
                      key: ValueKey('${state.index}-${state.isFlipped}'),
                      word: state.currentWord,
                      isFlipped: state.isFlipped,
                      onSound: () => bloc.add(const SoundPressed()),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Row(
                children: [
                  GlassIconButton(
                    icon: Icons.arrow_back_rounded,
                    tooltip: 'Previous card',
                    size: 56,
                    onPressed: state.isFirst
                        ? null
                        : () => bloc.add(const PreviousCardPressed()),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: BigButton(
                      text: state.isLast ? 'Finish' : 'Next',
                      onPressed: () => bloc.add(const NextCardPressed()),
                    ),
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
