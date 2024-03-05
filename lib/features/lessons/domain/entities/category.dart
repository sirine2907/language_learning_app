import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String title;
  final String japaneseTitle;
  // one kanji shown on the deck stamp
  final String stamp;
  final int color;
  final int wordCount;
  // Basic or Intermediate
  final String level;

  const Category({
    required this.id,
    required this.title,
    required this.japaneseTitle,
    required this.stamp,
    required this.color,
    required this.wordCount,
    required this.level,
  });

  @override
  List<Object?> get props =>
      [id, title, japaneseTitle, stamp, color, wordCount, level];
}
