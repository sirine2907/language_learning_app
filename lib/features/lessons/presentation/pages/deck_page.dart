import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/category.dart';
import '../bloc/deck/deck_bloc.dart';
import '../widgets/deck_controls.dart';
import '../widgets/deck_finished_view.dart';
import '../widgets/flashcard.dart';

class DeckPage extends StatelessWidget {
  final Category category;

  const DeckPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final accent = Color(category.color);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<DeckBloc, DeckState>(
          builder: (context, state) {
            if (state.status == DeckStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == DeckStatus.error) {
              return const Center(child: Text('Could not load this deck'));
            }

            if (state.status == DeckStatus.finished) {
              return DeckFinishedView(
                category: category,
                onRestart: () =>
                    context.read<DeckBloc>().add(const DeckRestarted()),
              );
            }

            final bloc = context.read<DeckBloc>();

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
                  child: Column(
                    children: [
                      _buildHeader(context, state, accent),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 20, 12, 16),
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
                                number: state.index + 1,
                                isFlipped: state.isFlipped,
                                accent: accent,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'tap the card to see the meaning · swipe to move',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColors.muted,
                            ),
                      ),
                      const SizedBox(height: 18),
                      DeckControls(
                        onPrevious: state.isFirst
                            ? null
                            : () => bloc.add(const PreviousCardPressed()),
                        onSound: () => bloc.add(const SoundPressed()),
                        onNext: () => bloc.add(const NextCardPressed()),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, DeckState state, Color accent) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.title,
                    style: textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    category.japaneseTitle,
                    style: textTheme.labelMedium!.copyWith(
                      color: AppColors.muted,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text(
                '${state.index + 1} / ${state.words.length}',
                style: textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (state.index + 1) / state.words.length,
              minHeight: 4,
              color: accent,
              backgroundColor: AppColors.line,
            ),
          ),
        ),
      ],
    );
  }
}
