import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/network/services.dart';
import 'package:flutter_course/core/utils/category_icon.dart';
import 'package:flutter_course/core/widgets/animated_list_item.dart';
import 'package:flutter_course/core/widgets/balance_summary.dart';
import 'package:flutter_course/core/widgets/error_state.dart';
import 'package:flutter_course/core/widgets/quick_action_button.dart';
import 'package:flutter_course/core/widgets/section_header.dart';
import 'package:flutter_course/core/widgets/stat_card.dart';
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
          final username = data.user['fullName'] ?? data.user['username'] ?? 'User';
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
                  child: _GreetingHeader(username: username as String),
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
                  child: const _QuickActions(),
                ),
                AnimatedListItem(
                  index: 3,
                  controller: _animController,
                  child: const SectionHeader(title: 'OVERVIEW'),
                ),
                AnimatedListItem(
                  index: 4,
                  controller: _animController,
                  child: _StatsGrid(stats: stats),
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

// ── Greeting Header ──────────────────────────────────────────────────────────

class _GreetingHeader extends StatelessWidget {
  final String username;

  const _GreetingHeader({required this.username});

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
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
                    '$_greeting,',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: ArgonColors.muted),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    username,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: ArgonColors.text),
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
              child: const Icon(Icons.notifications_none_rounded, color: ArgonColors.primary, size: 22),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Quick Actions ────────────────────────────────────────────────────────────

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          QuickActionButton(icon: Icons.arrow_upward_rounded, label: 'Send', color: ArgonColors.primary, onTap: () {}),
          QuickActionButton(icon: Icons.arrow_downward_rounded, label: 'Receive', color: ArgonColors.success, onTap: () {}),
          QuickActionButton(icon: Icons.swap_horiz_rounded, label: 'Transfer', color: ArgonColors.info, onTap: () {}),
          QuickActionButton(icon: Icons.qr_code_scanner_rounded, label: 'Scan', color: ArgonColors.warning, onTap: () {}),
        ],
      ),
    );
  }
}

// ── Stats Grid ───────────────────────────────────────────────────────────────

class _StatsGrid extends StatelessWidget {
  final Map<String, dynamic> stats;

  const _StatsGrid({required this.stats});

  String _formatCurrency(num value) => '\$${value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]},')}';

  @override
  Widget build(BuildContext context) {
    final income = (stats['income'] as num?) ?? 0;
    final expenses = (stats['expenses'] as num?) ?? 0;
    final savings = (stats['savings'] as num?) ?? 0;
    final txCount = (stats['transactionCount'] as num?) ?? 0;

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: StatCard(title: 'Income', value: _formatCurrency(income), icon: Icons.arrow_downward_rounded, color: ArgonColors.success, subtitle: '+12.5% vs last month')),
            const SizedBox(width: 12),
            Expanded(child: StatCard(title: 'Expenses', value: _formatCurrency(expenses), icon: Icons.arrow_upward_rounded, color: ArgonColors.error, subtitle: '-3.2% vs last month')),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: StatCard(title: 'Savings', value: _formatCurrency(savings), icon: Icons.savings_outlined, color: ArgonColors.info, subtitle: 'Goal: \$5,000')),
            const SizedBox(width: 12),
            Expanded(child: StatCard(title: 'Transactions', value: '$txCount', icon: Icons.receipt_long_outlined, color: ArgonColors.warning, subtitle: 'This month')),
          ],
        ),
      ],
    );
  }
}
