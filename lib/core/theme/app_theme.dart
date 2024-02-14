import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.red,
        primary: AppColors.red,
        surface: AppColors.card,
      ),
      scaffoldBackgroundColor: AppColors.paper,
    );

    // Zen Kaku Gothic for normal text, Shippori Mincho for the big titles.
    // Both have japanese letters so kana looks right everywhere.
    final body = GoogleFonts.zenKakuGothicNewTextTheme(base.textTheme).apply(
      bodyColor: AppColors.ink,
      displayColor: AppColors.ink,
    );

    return base.copyWith(
      textTheme: body.copyWith(
        displayLarge: GoogleFonts.shipporiMincho(
          textStyle: body.displayLarge,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: GoogleFonts.shipporiMincho(
          textStyle: body.displayMedium,
          fontWeight: FontWeight.w700,
        ),
        displaySmall: GoogleFonts.shipporiMincho(
          textStyle: body.displaySmall,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: GoogleFonts.shipporiMincho(
          textStyle: body.headlineMedium,
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: GoogleFonts.shipporiMincho(
          textStyle: body.headlineSmall,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
