import 'package:flutter/material.dart';
import 'package:flutter_course/core/widgets/stat_card.dart';

/// Data model for a stat item displayed in the grid.
class StatItem {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? subtitle;
  final VoidCallback? onTap;

  const StatItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.subtitle,
    this.onTap,
  });
}

/// A responsive grid that displays a list of [StatItem] in rows of 2.
///
/// Usage:
/// ```dart
/// StatsGrid(
///   items: [
///     StatItem(title: 'Income', value: '\$4,150', icon: Icons.arrow_downward, color: Colors.green),
///     StatItem(title: 'Expenses', value: '\$1,842', icon: Icons.arrow_upward, color: Colors.red),
///   ],
/// )
/// ```
class StatsGrid extends StatelessWidget {
  final List<StatItem> items;

  const StatsGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = [];

    for (var i = 0; i < items.length; i += 2) {
      final first = items[i];
      final second = (i + 1 < items.length) ? items[i + 1] : null;

      rows.add(
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: first.onTap,
                child: StatCard(
                  title: first.title,
                  value: first.value,
                  icon: first.icon,
                  color: first.color,
                  subtitle: first.subtitle,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: second != null
                  ? GestureDetector(
                      onTap: second.onTap,
                      child: StatCard(
                        title: second.title,
                        value: second.value,
                        icon: second.icon,
                        color: second.color,
                        subtitle: second.subtitle,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );

      if (i + 2 < items.length) {
        rows.add(const SizedBox(height: 12));
      }
    }

    return Column(children: rows);
  }
}
