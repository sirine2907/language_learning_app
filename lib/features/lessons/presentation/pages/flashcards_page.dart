import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/big_button.dart';
import '../../../../core/widgets/glass_icon_button.dart';
import '../../../../core/widgets/lesson_top_bar.dart';
import '../../../../core/widgets/purple_background.dart';
import '../../domain/entities/category.dart';
import '../bloc/deck/deck_bloc.dart';
import '../widgets/deck_finished_view.dart';
import '../widgets/flashcard.dart';

class FlashcardsPage extends StatelessWidget {
  final Category category;

  const FlashcardsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PurpleBackground(
        child: SafeArea(
          child: BlocBuilder<DeckBloc, DeckState>(
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
                return DeckFinishedView(
                  category: category,
                  onRestart: () =>
                      context.read<DeckBloc>().add(const DeckRestarted()),
                );
              }

              return _buildCards(context, state);
            },
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
