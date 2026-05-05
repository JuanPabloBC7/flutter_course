import 'package:flutter/material.dart';

/// Reusable staggered animation wrapper for list items.
///
/// Provides a consistent slide + fade animation used across
/// Dashboard, Transfers, History, Configuration, and Profile views.
class AnimatedListItem extends StatelessWidget {
  final int index;
  final AnimationController controller;
  final Widget child;

  const AnimatedListItem({
    super.key,
    required this.index,
    required this.controller,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final start = (index * 0.08).clamp(0.0, 0.6);
    final end = (start + 0.4).clamp(0.0, 1.0);

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.12),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      )),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: controller,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
        child: child,
      ),
    );
  }
}
