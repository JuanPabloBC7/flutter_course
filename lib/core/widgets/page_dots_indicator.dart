import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';

/// A row of dots indicating the current page in a PageView.
///
/// Usage:
/// ```dart
/// PageDotsIndicator(currentPage: 1, totalPages: 3)
/// ```
class PageDotsIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Color activeColor;
  final Color inactiveColor;
  final double activeSize;
  final double inactiveSize;

  const PageDotsIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.activeColor = ArgonColors.primary,
    this.inactiveColor = ArgonColors.border,
    this.activeSize = 10,
    this.inactiveSize = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        totalPages,
        (i) => Container(
          width: i == currentPage ? activeSize : inactiveSize,
          height: i == currentPage ? activeSize : inactiveSize,
          margin: const EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == currentPage ? activeColor : inactiveColor,
          ),
        ),
      ),
    );
  }
}
