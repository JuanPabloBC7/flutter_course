import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/utils/category_icon.dart';
import 'package:flutter_course/core/widgets/animated_list_item.dart';
import 'package:flutter_course/core/widgets/app_toast.dart';
import 'package:flutter_course/core/widgets/balance_summary.dart';
import 'package:flutter_course/core/widgets/error_state.dart';
import 'package:flutter_course/core/widgets/greeting_header.dart';
import 'package:flutter_course/core/widgets/quick_actions.dart';
import 'package:flutter_course/core/widgets/section_header.dart';
import 'package:flutter_course/core/widgets/stats_grid.dart';
import 'package:flutter_course/core/widgets/transaction_card.dart';
import 'package:flutter_course/features/pages/admin_app/admin/dashboard/providers/dashboard_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  String _formatCurrency(num value) {
    return '\$${value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]},')}';
  }

  @override
  Widget build(BuildContext context) {
    final dashboardAsync = ref.watch(dashboardProvider);

    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      body: dashboardAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: ArgonColors.primary),
        ),
        error: (error, _) => ErrorState(
          message: 'Error: $error',
          onRetry: () => ref.invalidate(dashboardProvider),
        ),
        data: (data) {
          _animController.forward(from: 0);

          final username = (data.user['fullName'] ?? data.user['username'] ?? 'User') as String;
          final totalBalance = (data.account['totalBalance'] as num).toDouble();
          final percentChange = (data.account['percentChange'] as num).toDouble();
          final stats = data.account['stats'] as Map<String, dynamic>;

          return RefreshIndicator(
            color: ArgonColors.primary,
            onRefresh: () async => ref.invalidate(dashboardProvider),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                AnimatedListItem(
                  index: 0,
                  controller: _animController,
                  child: GreetingHeader(username: username),
                ),
                AnimatedListItem(
                  index: 1,
                  controller: _animController,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: BalanceSummary(
                      totalBalance: totalBalance,
                      percentChange: percentChange,
                    ),
                  ),
                ),
                AnimatedListItem(
                  index: 2,
                  controller: _animController,
                  child: QuickActions(
                    items: [
                      QuickActionItem(
                        icon: Icons.arrow_upward_rounded,
                        label: 'Send',
                        color: ArgonColors.primary,
                        onTap: () => AppToast.success(
                          context,
                          title: 'Send Money',
                          message: 'Your transfer has been initiated successfully.',
                        ),
                      ),
                      QuickActionItem(
                        icon: Icons.arrow_downward_rounded,
                        label: 'Receive',
                        color: ArgonColors.success,
                        onTap: () => AppToast.info(
                          context,
                          title: 'Receive Money',
                          message: 'Share your account details to receive funds.',
                        ),
                      ),
                      QuickActionItem(
                        icon: Icons.swap_horiz_rounded,
                        label: 'Transfer',
                        color: ArgonColors.info,
                        onTap: () => AppToast.warning(
                          context,
                          title: 'Transfer Limit',
                          message: 'Daily transfer limit is \$10,000. Contact support to increase.',
                        ),
                      ),
                      QuickActionItem(
                        icon: Icons.qr_code_scanner_rounded,
                        label: 'Scan',
                        color: ArgonColors.warning,
                        onTap: () => AppToast.error(
                          context,
                          title: 'Camera Access',
                          message: 'Camera permission is required to scan QR codes.',
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedListItem(
                  index: 3,
                  controller: _animController,
                  child: const SectionHeader(title: 'OVERVIEW'),
                ),
                AnimatedListItem(
                  index: 4,
                  controller: _animController,
                  child: StatsGrid(
                    items: [
                      StatItem(
                        title: 'Income',
                        value: _formatCurrency((stats['income'] as num?) ?? 0),
                        icon: Icons.arrow_downward_rounded,
                        color: ArgonColors.success,
                        subtitle: '+12.5% vs last month',
                        onTap: () => AppToast.success(
                          context,
                          title: 'On press',
                          message: 'You on press successfully.',
                        ),
                      ),
                      StatItem(
                        title: 'Expenses',
                        value: _formatCurrency((stats['expenses'] as num?) ?? 0),
                        icon: Icons.arrow_upward_rounded,
                        color: ArgonColors.error,
                        subtitle: '-3.2% vs last month',
                        onTap: () => AppToast.success(
                          context,
                          title: 'On press',
                          message: 'You on press successfully.',
                        ),
                      ),
                      StatItem(
                        title: 'Savings',
                        value: _formatCurrency((stats['savings'] as num?) ?? 0),
                        icon: Icons.savings_outlined,
                        color: ArgonColors.info,
                        subtitle: 'Goal: \$5,000',
                        onTap: () => AppToast.success(
                          context,
                          title: 'On press',
                          message: 'You on press successfully.',
                        ),
                      ),
                      StatItem(
                        title: 'Transactions',
                        value: '${(stats['transactionCount'] as num?) ?? 0}',
                        icon: Icons.receipt_long_outlined,
                        color: ArgonColors.warning,
                        subtitle: 'This month',
                        onTap: () => AppToast.success(
                          context,
                          title: 'On press',
                          message: 'You on press successfully.',
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedListItem(
                  index: 5,
                  controller: _animController,
                  child: const SectionHeader(title: 'RECENT TRANSACTIONS'),
                ),
                ...data.transactions.take(4).toList().asMap().entries.map((entry) {
                  final tx = entry.value;
                  final isIncome = tx['type'] == 'income';
                  return AnimatedListItem(
                    index: 6 + entry.key,
                    controller: _animController,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TransactionCard(
                        title: tx['title'] as String,
                        date: tx['section'] as String,
                        amount: (tx['amount'] as num).toDouble(),
                        type: isIncome ? TransactionType.income : TransactionType.expense,
                        icon: CategoryIcon.fromCategory(tx['category'] as String),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
