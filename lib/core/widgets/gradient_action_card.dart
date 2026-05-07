import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';

/// A gradient card with an icon, title, subtitle, and a trailing action arrow.
///
/// Used as a "hero" call-to-action card (e.g., "Send Money" in Transfers).
/// Fully customizable: colors, icons, text, and tap callback.
///
/// Usage:
/// ```dart
/// GradientActionCard(
///   title: 'Send Money',
///   subtitle: 'Transfer to anyone, anywhere',
///   icon: Icons.send_rounded,
///   onTap: () => navigateToSend(),
/// )
/// ```
class GradientActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color? color;
  final VoidCallback? onTap;
  final bool showArrow;

  const GradientActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.color,
    this.onTap,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? ArgonColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 16, bottom: 4),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [cardColor, cardColor.withValues(alpha: 0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: cardColor.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: ArgonColors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: ArgonColors.white, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: ArgonColors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 13, color: Colors.white70),
                  ),
                ],
              ),
            ),
            if (showArrow)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: ArgonColors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: ArgonColors.white,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
