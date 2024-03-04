import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.purple,
        primary: AppColors.purple,
      ),
      scaffoldBackgroundColor: AppColors.purpleTop,
    );

    // Plus Jakarta Sans for normal text.
    // The display styles use Noto Sans JP because they show kanji and kana.
    final text = GoogleFonts.plusJakartaSansTextTheme(base.textTheme).apply(
      bodyColor: AppColors.ink,
      displayColor: AppColors.ink,
    );

    TextStyle japanese(TextStyle? style) {
      return GoogleFonts.notoSansJp(
        textStyle: style,
        fontWeight: FontWeight.w700,
      );
    }

    return base.copyWith(
      textTheme: text.copyWith(
        displayLarge: japanese(text.displayLarge),
        displayMedium: japanese(text.displayMedium),
        displaySmall: japanese(text.displaySmall),
        headlineSmall: japanese(text.headlineSmall),
      ),
    );
  }
}
