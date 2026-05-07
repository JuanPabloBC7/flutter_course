import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/network/services.dart';
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

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  final UserService _userService = UserService();
  final AccountService _accountService = AccountService();
  final TransactionService _transactionService = TransactionService();

  late Future<_DashboardData> _dataFuture;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _dataFuture = _loadData();
  }

  Future<_DashboardData> _loadData() async {
    final results = await Future.wait([
      _userService.fetchUser(),
      _accountService.fetchAccountSummary(),
      _transactionService.fetchTransactions(limit: 4),
    ]);

    return _DashboardData(
      user: results[0] as Map<String, dynamic>,
      account: results[1] as Map<String, dynamic>,
      transactions: results[2] as List<Map<String, dynamic>>,
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
    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      body: FutureBuilder<_DashboardData>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: ArgonColors.primary),
            );
          }

          if (snapshot.hasError) {
            return ErrorState(
              message: 'Error: ${snapshot.error}',
              onRetry: () => setState(() => _dataFuture = _loadData()),
            );
          }

          final data = snapshot.data!;
          final username = (data.user['fullName'] ?? data.user['username'] ?? 'User') as String;
          final totalBalance = (data.account['totalBalance'] as num).toDouble();
          final percentChange = (data.account['percentChange'] as num).toDouble();
          final stats = data.account['stats'] as Map<String, dynamic>;

          _animController.forward(from: 0);

          return RefreshIndicator(
            color: ArgonColors.primary,
            onRefresh: () async {
              setState(() => _dataFuture = _loadData());
            },
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
                ..._buildRecentTransactions(data.transactions),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildRecentTransactions(List<Map<String, dynamic>> transactions) {
    final recent = transactions.take(4).toList();

    return recent.asMap().entries.map((entry) {
      final i = entry.key;
      final tx = entry.value;
      final isIncome = tx['type'] == 'income';

      return AnimatedListItem(
        index: 6 + i,
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
    }).toList();
  }
}

// ── Data container ───────────────────────────────────────────────────────────

class _DashboardData {
  final Map<String, dynamic> user;
  final Map<String, dynamic> account;
  final List<Map<String, dynamic>> transactions;

  const _DashboardData({
    required this.user,
    required this.account,
    required this.transactions,
  });
}
