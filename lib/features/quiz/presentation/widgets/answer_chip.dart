import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

enum AnswerLook { normal, correct, wrong, faded }

class AnswerChip extends StatelessWidget {
  final String text;
  final AnswerLook look;
  final VoidCallback? onTap;

  const AnswerChip({
    super.key,
    required this.text,
    required this.look,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color background = AppColors.white;
    Color border = AppColors.line;
    Color textColor = AppColors.ink;
    IconData? icon;

    if (look == AnswerLook.correct) {
      background = AppColors.greenSoft;
      border = AppColors.green;
      textColor = AppColors.green;
      icon = Icons.check_circle_rounded;
    } else if (look == AnswerLook.wrong) {
      background = AppColors.redSoft;
      border = AppColors.red;
      textColor = AppColors.red;
      icon = Icons.cancel_rounded;
    } else if (look == AnswerLook.faded) {
      textColor = AppColors.muted;
    }

    return Material(
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: border, width: 1.5),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 6),
                Icon(icon, size: 18, color: textColor),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
