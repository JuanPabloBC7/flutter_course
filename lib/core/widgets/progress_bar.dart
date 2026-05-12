import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';

/// A horizontal progress bar that fills based on a fraction (0.0 to 1.0).
///
/// Usage:
/// ```dart
/// ProgressBar(progress: 0.66, height: 6)
/// ```
class ProgressBar extends StatelessWidget {
  final double progress;
  final double height;
  final Color activeColor;
  final Color backgroundColor;

  const ProgressBar({
    super.key,
    required this.progress,
    this.height = 6,
    this.activeColor = ArgonColors.primary,
    this.backgroundColor = ArgonColors.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: activeColor,
            borderRadius: BorderRadius.circular(height / 2),
          ),
        ),
      ),
    );
  }
}
