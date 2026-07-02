import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/l10n/app_localizations.dart';

/// Header widget that displays a time-based greeting and the user's name.
///
/// Shows "Good morning/afternoon/evening" based on the current hour,
/// along with a notification bell icon.
class GreetingHeader extends StatelessWidget {
  final String username;

  const GreetingHeader({super.key, required this.username});

  String _greeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.goodMorning;
    if (hour < 18) return l10n.goodAfternoon;
    return l10n.goodEvening;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_greeting(l10n)},',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ArgonColors.muted,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: ArgonColors.text,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: ArgonColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                color: ArgonColors.primary,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
