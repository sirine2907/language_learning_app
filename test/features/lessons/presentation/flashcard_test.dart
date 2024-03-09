import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:language_learning_app/features/lessons/domain/entities/word.dart';
import 'package:language_learning_app/features/lessons/presentation/widgets/flashcard.dart';

void main() {
  const word = Word(
    romaji: 'haha',
    kana: '母 はは',
    english: 'mother',
    sound: 'sounds/family_members/mother.wav',
  );

  Widget buildCard(bool isFlipped, {VoidCallback? onSound}) {
    return MaterialApp(
      home: Scaffold(
        body: Flashcard(
          word: word,
          isFlipped: isFlipped,
          onSound: onSound ?? () {},
        ),
      ),
    );
  }

  testWidgets('front shows japanese and romaji but not english',
      (tester) async {
    await tester.pumpWidget(buildCard(false));

    expect(find.text('母 はは'), findsOneWidget);
    expect(find.text('haha'), findsOneWidget);
    expect(find.text('mother'), findsNothing);
  });

  testWidgets('back shows the english meaning', (tester) async {
    await tester.pumpWidget(buildCard(true));

    expect(find.text('mother'), findsOneWidget);
    expect(find.text('意味 · meaning'), findsOneWidget);
  });

  testWidgets('listen button calls onSound', (tester) async {
    int pressed = 0;
    await tester.pumpWidget(buildCard(false, onSound: () => pressed++));

    await tester.tap(find.text('listen'));
    expect(pressed, 1);
  });
}
