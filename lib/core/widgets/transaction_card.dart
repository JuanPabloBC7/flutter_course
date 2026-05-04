import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';

enum TransactionType { income, expense }

class TransactionCard extends StatelessWidget {
  final String title;
  final String date;
  final double amount;
  final TransactionType type;
  final IconData? icon;
  final VoidCallback? onTap;

  const TransactionCard({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = type == TransactionType.income;
    final amountColor = isIncome ? ArgonColors.success : ArgonColors.error;
    final amountPrefix = isIncome ? '+' : '-';
    final iconBgColor = isIncome
        ? ArgonColors.success.withValues(alpha: 0.12)
        : ArgonColors.error.withValues(alpha: 0.12);
    final iconColor = isIncome ? ArgonColors.success : ArgonColors.error;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
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
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon ?? Icons.attach_money,
                  color: iconColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: ArgonColors.text,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: ArgonColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '$amountPrefix\$${amount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: amountColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
