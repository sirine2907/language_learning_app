import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/category.dart';
import '../../../domain/usecases/get_categories.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategories getCategories;

  CategoriesBloc({required this.getCategories})
      : super(const CategoriesLoading()) {
    on<CategoriesRequested>(_onRequested);
  }

  Future<void> _onRequested(
    CategoriesRequested event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(const CategoriesLoading());
    try {
      final categories = await getCategories();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(const CategoriesError('Could not load the decks'));
    }
  }
}
