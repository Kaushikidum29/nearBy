import 'package:flutter/material.dart';
import 'package:near_by/features/search/presentation/widgets/floating_action_buttons.dart';

class FABButtons extends StatelessWidget {
  final double opacity;
  final double bottomOffset;
  final VoidCallback onPressed;

  const FABButtons({
    super.key,
    required this.opacity,
    required this.bottomOffset,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottomOffset,
      right: 16,
      child: AnimatedOpacity(
        opacity: opacity,
        duration: const Duration(milliseconds: 250),
        child: IgnorePointer(
          ignoring: opacity == 0,
          child: FloatingActionButtons(callBack: onPressed),
        ),
      ),
    );
  }
}
