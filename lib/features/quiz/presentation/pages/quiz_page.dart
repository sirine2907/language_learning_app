import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/big_button.dart';
import '../../../../core/widgets/lesson_top_bar.dart';
import '../../../../core/widgets/purple_background.dart';
import '../../../../core/widgets/sound_pill.dart';
import '../../../lessons/domain/entities/category.dart';
import '../../../progress/presentation/bloc/progress_bloc.dart';
import '../../../progress/presentation/pages/result_page.dart';
import '../bloc/quiz_bloc.dart';
import '../quiz_route.dart';
import '../widgets/answer_chip.dart';

class QuizPage extends StatelessWidget {
  final Category category;

  const QuizPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PurpleBackground(
        child: SafeArea(
          child: BlocConsumer<QuizBloc, QuizState>(
            listener: (context, state) {
              if (state.status == QuizStatus.finished) {
                _showResult(context, state);
              }
            },
            builder: (context, state) {
              if (state.status == QuizStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.white),
                );
              }

              if (state.status == QuizStatus.error) {
                return const Center(
                  child: Text(
                    'Could not make the quiz',
                    style: TextStyle(color: AppColors.white),
                  ),
                );
              }

              if (state.status == QuizStatus.finished) {
                return const SizedBox();
              }

              return _buildQuestion(context, state);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(BuildContext context, QuizState state) {
    final bloc = context.read<QuizBloc>();
    final textTheme = Theme.of(context).textTheme;
    final question = state.currentQuestion;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          children: [
            LessonTopBar(
              progress: (state.index + 1) / state.questions.length,
              counter: '${state.index + 1}/${state.questions.length}',
              onClose: () => Navigator.pop(context),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Listen and pick the meaning',
                          style: textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SoundPill(
                          onPressed: () => bloc.add(const QuizSoundPressed()),
                        ),
                        const SizedBox(height: 28),
                        Center(
                          child: Text(
                            question.word.kana,
                            textAlign: TextAlign.center,
                            style: question.word.hasImage
                                ? textTheme.displaySmall!.copyWith(fontSize: 34)
                                : textTheme.headlineSmall,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Center(
                          child: Text(
                            // the romaji shows after answering, so you read the kana first
                            state.isAnswered ? question.word.romaji : ' ',
                            style: textTheme.titleSmall!.copyWith(
                              color: AppColors.muted,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(height: 1, color: AppColors.line),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            for (final option in question.options)
                              AnswerChip(
                                text: option,
                                look: _lookFor(state, option),
                                onTap: state.isAnswered
                                    ? null
                                    : () => bloc.add(AnswerSelected(option)),
                              ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        if (state.isAnswered) _buildFeedback(context, state),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: BigButton(
                text: state.isLast ? 'See results' : 'Next',
                onPressed: state.isAnswered
                    ? () => bloc.add(const NextQuestionPressed())
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnswerLook _lookFor(QuizState state, String option) {
    if (!state.isAnswered) return AnswerLook.normal;
    if (option == state.currentQuestion.answer) return AnswerLook.correct;
    if (option == state.selected) return AnswerLook.wrong;
    return AnswerLook.faded;
  }

  Widget _buildFeedback(BuildContext context, QuizState state) {
    final isCorrect = state.selected == state.currentQuestion.answer;

    return Text(
      isCorrect ? 'Correct! すごい!' : 'Not this time, it means "${state.currentQuestion.answer}"',
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: isCorrect ? AppColors.green : AppColors.red,
            fontWeight: FontWeight.w700,
          ),
    );
  }

  void _showResult(BuildContext context, QuizState state) {
    context.read<ProgressBloc>().add(const ProgressRequested());

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (resultContext) => ResultPage(
          title: '${category.title} Quiz',
          subtitle: 'Japanese · Quiz',
          stats: [
            ResultStat(
              Icons.help_outline,
              'Questions',
              '${state.correctCount}/${state.questions.length}',
            ),
            ResultStat(
              Icons.schedule,
              'Time',
              ResultPage.formatTime(state.timeSpent),
            ),
            ResultStat(Icons.emoji_events_outlined, 'Score', '${state.score}%'),
          ],
          conclusion: _conclusion(state.score),
          onTryAgain: () => Navigator.pushReplacement(
            resultContext,
            quizRoute(resultContext, category),
          ),
        ),
      ),
    );
  }

  String _conclusion(int score) {
    if (score >= 80) {
      return 'Great job! You know almost every word of ${category.title}. '
          'Try another lesson or come back tomorrow to keep your streak going.';
    }
    if (score >= 50) {
      return 'Not bad! Go through the cards you missed one more time '
          'and try the quiz again, you are almost there.';
    }
    return 'Keep going! Study the cards first and listen to every word, '
        'then come back and try the quiz again.';
  }
}
