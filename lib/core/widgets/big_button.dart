import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

// the wide round button at the bottom of the screens
class BigButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  // white button with purple text, or see-through with white text
  final bool filled;

  const BigButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.filled = true,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null;

    Color background = filled ? AppColors.white : AppColors.glass;
    Color textColor = filled ? AppColors.purple : AppColors.white;
    if (disabled) {
      background = AppColors.glassLight;
      textColor = AppColors.whiteMuted;
    }

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(28),
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
