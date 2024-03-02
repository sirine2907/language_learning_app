import 'package:equatable/equatable.dart';

class Progress extends Equatable {
  // category id -> best quiz score in percent
  final Map<String, int> bestScores;
  // days when I finished at least one deck or quiz
  final List<DateTime> practiceDays;

  const Progress({
    this.bestScores = const {},
    this.practiceDays = const [],
  });

  int scoreFor(String categoryId) => bestScores[categoryId] ?? 0;

  bool practicedOn(DateTime day) {
    for (final practiceDay in practiceDays) {
      if (practiceDay.year == day.year &&
          practiceDay.month == day.month &&
          practiceDay.day == day.day) {
        return true;
      }
    }
    return false;
  }

  // how many days in a row, today does not break it if I didn't practice yet
  int streak(DateTime today) {
    var day = DateTime(today.year, today.month, today.day);
    if (!practicedOn(day)) {
      day = DateTime(day.year, day.month, day.day - 1);
    }

    int count = 0;
    while (practicedOn(day)) {
      count++;
      day = DateTime(day.year, day.month, day.day - 1);
    }
    return count;
  }

  @override
  List<Object?> get props => [bestScores, practiceDays];
}
