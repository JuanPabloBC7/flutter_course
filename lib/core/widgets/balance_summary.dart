import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';

class BalanceSummary extends StatelessWidget {
  final double totalBalance;
  final double percentChange;

  const BalanceSummary({
    super.key,
    required this.totalBalance,
    required this.percentChange,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = percentChange >= 0;
    final changeColor = isPositive ? ArgonColors.success : ArgonColors.error;
    final changeIcon = isPositive ? Icons.trending_up : Icons.trending_down;
    final changePrefix = isPositive ? '+' : '';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ArgonColors.primary,
            ArgonColors.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ArgonColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Balance',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${totalBalance.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: ArgonColors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: changeColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(changeIcon, color: ArgonColors.white, size: 16),
                const SizedBox(width: 4),
                Text(
                  '$changePrefix${percentChange.toStringAsFixed(1)}% this month',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: ArgonColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
