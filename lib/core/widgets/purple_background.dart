import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class PurpleBackground extends StatelessWidget {
  final Widget child;

  const PurpleBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.purpleTop, AppColors.purpleBottom],
        ),
      ),
      child: child,
    );
  }
}
