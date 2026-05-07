import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';

/// Data model for an option tile item.
class OptionItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback? onTap;

  const OptionItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.onTap,
  });
}

/// A responsive grid of option tiles displayed in rows of 2.
///
/// Each tile has an icon, title, subtitle, and tap callback.
/// Used for transfer options, payment methods, or any categorized actions.
///
/// Usage:
/// ```dart
/// OptionsGrid(
///   items: [
///     OptionItem(icon: Icons.account_balance, title: 'Bank', subtitle: 'To account', color: Colors.blue, onTap: () {}),
///     OptionItem(icon: Icons.phone, title: 'Mobile', subtitle: 'To phone', color: Colors.green, onTap: () {}),
///   ],
/// )
/// ```
class OptionsGrid extends StatelessWidget {
  final List<OptionItem> items;

  const OptionsGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = [];

    for (var i = 0; i < items.length; i += 2) {
      final first = items[i];
      final second = (i + 1 < items.length) ? items[i + 1] : null;

      rows.add(
        Row(
          children: [
            Expanded(child: _OptionTile(item: first)),
            const SizedBox(width: 12),
            Expanded(
              child: second != null
                  ? _OptionTile(item: second)
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

class _OptionTile extends StatelessWidget {
  final OptionItem item;

  const _OptionTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ArgonColors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: ArgonColors.initial.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: item.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item.icon, color: item.color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              item.title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: ArgonColors.text),
            ),
            const SizedBox(height: 2),
            Text(
              item.subtitle,
              style: const TextStyle(fontSize: 11, color: ArgonColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}
