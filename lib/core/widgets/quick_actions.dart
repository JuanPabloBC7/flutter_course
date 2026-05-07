import 'package:flutter/material.dart';
import 'package:flutter_course/core/widgets/quick_action_button.dart';

/// Data model for a quick action item.
class QuickActionItem {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const QuickActionItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}

/// A row of quick action buttons built from a dynamic list of [QuickActionItem].
///
/// Usage:
/// ```dart
/// QuickActions(
///   items: [
///     QuickActionItem(icon: Icons.send, label: 'Send', color: Colors.blue, onTap: () {}),
///     QuickActionItem(icon: Icons.download, label: 'Receive', color: Colors.green, onTap: () {}),
///   ],
/// )
/// ```
class QuickActions extends StatelessWidget {
  final List<QuickActionItem> items;

  const QuickActions({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items
            .map((item) => QuickActionButton(
                  icon: item.icon,
                  label: item.label,
                  color: item.color,
                  onTap: item.onTap,
                ))
            .toList(),
      ),
    );
  }
}
