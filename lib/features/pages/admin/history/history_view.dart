import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/widgets/balance_summary.dart';
import 'package:flutter_course/core/widgets/section_header.dart';
import 'package:flutter_course/core/widgets/transaction_card.dart';

// ── Mock data model ──────────────────────────────────────────────────────────

class _Transaction {
  final String title;
  final String date;
  final double amount;
  final TransactionType type;
  final IconData icon;
  final String section;

  const _Transaction({
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
    required this.icon,
    required this.section,
  });
}

const List<_Transaction> _mockTransactions = [
  // Today
  _Transaction(
    title: 'Salary Deposit',
    date: 'Today, 9:41 AM',
    amount: 3500.00,
    type: TransactionType.income,
    icon: Icons.account_balance,
    section: 'Today',
  ),
  _Transaction(
    title: 'Grocery Store',
    date: 'Today, 2:15 PM',
    amount: 85.40,
    type: TransactionType.expense,
    icon: Icons.shopping_cart,
    section: 'Today',
  ),
  _Transaction(
    title: 'Freelance Payment',
    date: 'Today, 5:30 PM',
    amount: 450.00,
    type: TransactionType.income,
    icon: Icons.work_outline,
    section: 'Today',
  ),
  // Yesterday
  _Transaction(
    title: 'Netflix Subscription',
    date: 'Yesterday, 8:00 AM',
    amount: 15.99,
    type: TransactionType.expense,
    icon: Icons.movie_outlined,
    section: 'Yesterday',
  ),
  _Transaction(
    title: 'Transfer from Juan',
    date: 'Yesterday, 11:20 AM',
    amount: 200.00,
    type: TransactionType.income,
    icon: Icons.person_outline,
    section: 'Yesterday',
  ),
  _Transaction(
    title: 'Electric Bill',
    date: 'Yesterday, 3:45 PM',
    amount: 120.50,
    type: TransactionType.expense,
    icon: Icons.bolt,
    section: 'Yesterday',
  ),
  // This week
  _Transaction(
    title: 'Restaurant',
    date: 'Mon, 7:30 PM',
    amount: 62.00,
    type: TransactionType.expense,
    icon: Icons.restaurant,
    section: 'This Week',
  ),
  _Transaction(
    title: 'Refund - Amazon',
    date: 'Mon, 10:00 AM',
    amount: 34.99,
    type: TransactionType.income,
    icon: Icons.replay,
    section: 'This Week',
  ),
  _Transaction(
    title: 'Gas Station',
    date: 'Sun, 6:15 PM',
    amount: 55.00,
    type: TransactionType.expense,
    icon: Icons.local_gas_station,
    section: 'This Week',
  ),
  _Transaction(
    title: 'Gym Membership',
    date: 'Sat, 9:00 AM',
    amount: 40.00,
    type: TransactionType.expense,
    icon: Icons.fitness_center,
    section: 'This Week',
  ),
];

// ── History View ─────────────────────────────────────────────────────────────

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  List<_Transaction> _transactions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    setState(() => _isLoading = true);
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() {
      _transactions = List.from(_mockTransactions);
      _isLoading = false;
    });
    _animController.forward(from: 0);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  // Group transactions by section
  List<dynamic> _buildGroupedList() {
    final List<dynamic> items = [];
    String? lastSection;

    for (final tx in _transactions) {
      if (tx.section != lastSection) {
        items.add(tx.section); // section header (String)
        lastSection = tx.section;
      }
      items.add(tx); // transaction item
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      appBar: AppBar(
        backgroundColor: ArgonColors.white,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const Text(
          'History',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ArgonColors.text,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded,
                color: ArgonColors.text, size: 24),
            onPressed: () {
              _showFilterSheet(context);
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: ArgonColors.primary))
          : _transactions.isEmpty
              ? _buildEmptyState()
              : RefreshIndicator(
                  color: ArgonColors.primary,
                  onRefresh: _loadTransactions,
                  child: _buildTransactionList(),
                ),
    );
  }

  Widget _buildTransactionList() {
    final groupedItems = _buildGroupedList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: groupedItems.length + 1, // +1 for balance summary
      itemBuilder: (context, index) {
        // Balance summary at the top
        if (index == 0) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: _animController,
              curve: Curves.easeOut,
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 16, bottom: 4),
              child: BalanceSummary(
                totalBalance: 12458.75,
                percentChange: 8.3,
              ),
            ),
          );
        }

        final item = groupedItems[index - 1];

        // Section header
        if (item is String) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: _animController,
              curve: Curves.easeOut,
            ),
            child: SectionHeader(title: item.toUpperCase()),
          );
        }

        // Transaction card with staggered animation
        final tx = item as _Transaction;
        final itemIndex = groupedItems
            .sublist(0, index - 1)
            .whereType<_Transaction>()
            .length;

        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.15),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _animController,
            curve: Interval(
              (itemIndex * 0.06).clamp(0.0, 0.7),
              ((itemIndex * 0.06) + 0.4).clamp(0.0, 1.0),
              curve: Curves.easeOutCubic,
            ),
          )),
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: _animController,
              curve: Interval(
                (itemIndex * 0.06).clamp(0.0, 0.7),
                ((itemIndex * 0.06) + 0.4).clamp(0.0, 1.0),
                curve: Curves.easeOut,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TransactionCard(
                title: tx.title,
                date: tx.date,
                amount: tx.amount,
                type: tx.type,
                icon: tx.icon,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined,
              size: 64, color: ArgonColors.muted.withOpacity(0.5)),
          const SizedBox(height: 16),
          const Text(
            'No transactions yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: ArgonColors.text,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your transaction history will appear here',
            style: TextStyle(
              fontSize: 14,
              color: ArgonColors.muted,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ArgonColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: ArgonColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Filter Transactions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: ArgonColors.text,
                  ),
                ),
                const SizedBox(height: 16),
                _FilterOption(
                  label: 'All',
                  icon: Icons.list,
                  onTap: () => Navigator.pop(context),
                ),
                _FilterOption(
                  label: 'Income',
                  icon: Icons.arrow_downward,
                  iconColor: ArgonColors.success,
                  onTap: () => Navigator.pop(context),
                ),
                _FilterOption(
                  label: 'Expenses',
                  icon: Icons.arrow_upward,
                  iconColor: ArgonColors.error,
                  onTap: () => Navigator.pop(context),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── Filter option widget (private, only used in filter sheet) ────────────────

class _FilterOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback onTap;

  const _FilterOption({
    required this.label,
    required this.icon,
    this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: iconColor ?? ArgonColors.primary),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: ArgonColors.text,
        ),
      ),
      onTap: onTap,
    );
  }
}
