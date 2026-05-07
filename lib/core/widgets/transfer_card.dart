import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/widgets/contact_avatar.dart';

/// Status types for a transfer.
enum TransferStatus { completed, pending, failed }

/// A card displaying a recent transfer with avatar, name, date, amount, and status badge.
///
/// Usage:
/// ```dart
/// TransferCard(
///   name: 'Ana García',
///   date: 'Today, 10:30 AM',
///   amount: 250.00,
///   status: TransferStatus.completed,
///   avatarColor: Colors.blue,
///   onTap: () => viewDetails(),
/// )
/// ```
class TransferCard extends StatelessWidget {
  final String name;
  final String date;
  final double amount;
  final TransferStatus status;
  final Color avatarColor;
  final VoidCallback? onTap;
  final String? amountPrefix;

  const TransferCard({
    super.key,
    required this.name,
    required this.date,
    required this.amount,
    required this.status,
    required this.avatarColor,
    this.onTap,
    this.amountPrefix = '-',
  });

  Color get _statusColor {
    switch (status) {
      case TransferStatus.completed:
        return ArgonColors.success;
      case TransferStatus.pending:
        return ArgonColors.warning;
      case TransferStatus.failed:
        return ArgonColors.error;
    }
  }

  String get _statusLabel {
    switch (status) {
      case TransferStatus.completed:
        return 'Completed';
      case TransferStatus.pending:
        return 'Pending';
      case TransferStatus.failed:
        return 'Failed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: ArgonColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: ArgonColors.initial.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ContactAvatar(name: name, color: avatarColor, size: 44, showLabel: false),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: ArgonColors.text),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(date, style: const TextStyle(fontSize: 12, color: ArgonColors.muted)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$amountPrefix\$${amount.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: ArgonColors.text),
                ),
                const SizedBox(height: 3),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _statusLabel,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _statusColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
