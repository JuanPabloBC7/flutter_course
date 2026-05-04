import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/network/services.dart';
import 'package:flutter_course/core/widgets/balance_summary.dart';
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
  late Future<Map<String, dynamic>> _userFuture;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _userFuture = UserService().fetchUser();
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
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: ArgonColors.primary),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline,
                      size: 48, color: ArgonColors.error.withOpacity(0.7)),
                  const SizedBox(height: 12),
                  const Text(
                    'Error loading data',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ArgonColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _userFuture = UserService().fetchUser();
                      });
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final userData = snapshot.data;
          final username = userData?['username'] ?? 'User';

          _animController.forward(from: 0);

          return RefreshIndicator(
            color: ArgonColors.primary,
            onRefresh: () async {
              setState(() {
                _userFuture = UserService().fetchUser();
              });
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                // ── Greeting header ──
                _buildAnimatedItem(
                  index: 0,
                  child: _GreetingHeader(username: username),
                ),

                // ── Balance card ──
                _buildAnimatedItem(
                  index: 1,
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: BalanceSummary(
                      totalBalance: 12458.75,
                      percentChange: 8.3,
                    ),
                  ),
                ),

                // ── Quick actions ──
                _buildAnimatedItem(
                  index: 2,
                  child: const _QuickActions(),
                ),

                // ── Stats grid ──
                _buildAnimatedItem(
                  index: 3,
                  child: const SectionHeader(title: 'OVERVIEW'),
                ),
                _buildAnimatedItem(
                  index: 4,
                  child: const _StatsGrid(),
                ),

                // ── Recent transactions ──
                _buildAnimatedItem(
                  index: 5,
                  child: const SectionHeader(title: 'RECENT TRANSACTIONS'),
                ),
                ..._buildRecentTransactions(),

                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedItem({required int index, required Widget child}) {
    final start = (index * 0.08).clamp(0.0, 0.6);
    final end = (start + 0.4).clamp(0.0, 1.0);

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.12),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animController,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      )),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: _animController,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
        child: child,
      ),
    );
  }

  List<Widget> _buildRecentTransactions() {
    const transactions = [
      {'title': 'Salary Deposit', 'date': 'Today, 9:41 AM', 'amount': 3500.0, 'type': TransactionType.income, 'icon': Icons.account_balance},
      {'title': 'Grocery Store', 'date': 'Today, 2:15 PM', 'amount': 85.40, 'type': TransactionType.expense, 'icon': Icons.shopping_cart},
      {'title': 'Freelance Payment', 'date': 'Yesterday, 5:30 PM', 'amount': 450.0, 'type': TransactionType.income, 'icon': Icons.work_outline},
      {'title': 'Netflix Subscription', 'date': 'Yesterday, 8:00 AM', 'amount': 15.99, 'type': TransactionType.expense, 'icon': Icons.movie_outlined},
    ];

    return transactions.asMap().entries.map((entry) {
      final i = entry.key;
      final tx = entry.value;
      return _buildAnimatedItem(
        index: 6 + i,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TransactionCard(
            title: tx['title'] as String,
            date: tx['date'] as String,
            amount: tx['amount'] as double,
            type: tx['type'] as TransactionType,
            icon: tx['icon'] as IconData,
          ),
        ),
      );
    }).toList();
  }
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
                color: ArgonColors.primary.withOpacity(0.12),
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
          _QuickActionButton(
            icon: Icons.arrow_upward_rounded,
            label: 'Send',
            color: ArgonColors.primary,
            onTap: () {},
          ),
          _QuickActionButton(
            icon: Icons.arrow_downward_rounded,
            label: 'Receive',
            color: ArgonColors.success,
            onTap: () {},
          ),
          _QuickActionButton(
            icon: Icons.swap_horiz_rounded,
            label: 'Transfer',
            color: ArgonColors.info,
            onTap: () {},
          ),
          _QuickActionButton(
            icon: Icons.qr_code_scanner_rounded,
            label: 'Scan',
            color: ArgonColors.warning,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: ArgonColors.text,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stats Grid ───────────────────────────────────────────────────────────────

class _StatsGrid extends StatelessWidget {
  const _StatsGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: 'Income',
                value: '\$4,150',
                icon: Icons.arrow_downward_rounded,
                color: ArgonColors.success,
                subtitle: '+12.5% vs last month',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                title: 'Expenses',
                value: '\$1,842',
                icon: Icons.arrow_upward_rounded,
                color: ArgonColors.error,
                subtitle: '-3.2% vs last month',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: 'Savings',
                value: '\$2,308',
                icon: Icons.savings_outlined,
                color: ArgonColors.info,
                subtitle: 'Goal: \$5,000',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                title: 'Transactions',
                value: '48',
                icon: Icons.receipt_long_outlined,
                color: ArgonColors.warning,
                subtitle: 'This month',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
