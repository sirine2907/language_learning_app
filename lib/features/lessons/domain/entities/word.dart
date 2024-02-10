import 'package:equatable/equatable.dart';

class Word extends Equatable {
  final String romaji;
  final String kana;
  final String english;
  final String sound;
  final String? image;

  const Word({
    required this.romaji,
    required this.kana,
    required this.english,
    required this.sound,
    this.image,
  });

  bool get hasImage => image != null;

  @override
  List<Object?> get props => [romaji, kana, english, sound, image];
}
