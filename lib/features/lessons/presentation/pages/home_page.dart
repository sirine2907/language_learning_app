import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../bloc/categories/categories_bloc.dart';
import '../widgets/category_deck_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CategoriesError) {
              return Center(child: Text(state.message));
            }

            final loaded = state as CategoriesLoaded;

            return ListView(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              children: [
                Text(
                  'こんにちは',
                  style: textTheme.titleMedium!.copyWith(
                    color: AppColors.red,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '日本語',
                  style: textTheme.displayMedium!.copyWith(height: 1.15),
                ),
                const SizedBox(height: 4),
                Text(
                  'Japanese flashcards · ${loaded.categories.length} decks · '
                  '${loaded.totalWords} words',
                  style: textTheme.bodyMedium!.copyWith(color: AppColors.muted),
                ),
                const SizedBox(height: 20),
                const Divider(color: AppColors.line, height: 1),
                const SizedBox(height: 26),
                for (final category in loaded.categories)
                  CategoryDeckCard(
                    category: category,
                    onTap: () {
                      // TODO open the deck page
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
