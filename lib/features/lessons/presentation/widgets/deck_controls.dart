import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class DeckControls extends StatelessWidget {
  final VoidCallback? onPrevious;
  final VoidCallback onSound;
  final VoidCallback onNext;

  const DeckControls({
    super.key,
    required this.onPrevious,
    required this.onSound,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _RoundButton(
          icon: Icons.arrow_back,
          tooltip: 'Previous card',
          onPressed: onPrevious,
        ),
        const SizedBox(width: 28),
        _RoundButton(
          icon: Icons.volume_up_rounded,
          tooltip: 'Play sound',
          onPressed: onSound,
          big: true,
        ),
        const SizedBox(width: 28),
        _RoundButton(
          icon: Icons.arrow_forward,
          tooltip: 'Next card',
          onPressed: onNext,
        ),
      ],
    );
  }
}

class _RoundButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final bool big;

  const _RoundButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.big = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = big ? 72.0 : 52.0;
    final disabled = onPressed == null;

    return Tooltip(
      message: tooltip,
      child: Material(
        color: big ? AppColors.red : AppColors.card,
        shape: CircleBorder(
          side: big
              ? BorderSide.none
              : const BorderSide(color: AppColors.line, width: 1.5),
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: SizedBox(
            width: size,
            height: size,
            child: Icon(
              icon,
              size: big ? 34 : 24,
              color: big
                  ? Colors.white
                  : (disabled ? AppColors.line : AppColors.ink),
            ),
          ),
        ),
      ),
    );
  }
}
