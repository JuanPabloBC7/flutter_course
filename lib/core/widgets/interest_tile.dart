import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';

/// A selectable tile that toggles between selected/unselected states.
///
/// When selected: blue background, blue border, check icon.
/// When unselected: white background, grey border, no icon.
///
/// Usage:
/// ```dart
/// InterestTile(
///   label: 'User Interface',
///   isSelected: true,
///   onTap: () => toggleSelection(),
/// )
/// ```
class InterestTile extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const InterestTile({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? ArgonColors.primary.withValues(alpha: 0.06)
              : ArgonColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? ArgonColors.primary.withValues(alpha: 0.3)
                : ArgonColors.border,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: ArgonColors.text,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_rounded,
                color: ArgonColors.primary,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}
