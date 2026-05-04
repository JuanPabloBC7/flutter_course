import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/network/services.dart';
import 'package:flutter_course/core/widgets/balance_summary.dart';
import 'package:flutter_course/core/widgets/section_header.dart';
import 'package:flutter_course/core/widgets/transaction_card.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  final TransactionService _transactionService = TransactionService();
  final AccountService _accountService = AccountService();

  List<Map<String, dynamic>> _transactions = [];
  Map<String, dynamic>? _accountData;
  bool _isLoading = true;
  String? _activeFilter;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _loadData();
  }

  Future<void> _loadData({String? filter}) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final results = await Future.wait([
        _transactionService.fetchTransactions(filter: filter),
        if (_accountData == null) _accountService.fetchAccountSummary(),
      ]);

      if (!mounted) return;

      setState(() {
        _transactions = results[0] as List<Map<String, dynamic>>;
        if (results.length > 1) {
          _accountData = results[1] as Map<String, dynamic>;
        }
        _activeFilter = filter;
        _isLoading = false;
      });
      _animController.forward(from: 0);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  IconData _iconForCategory(String category) {
    switch (category) {
      case 'salary':
        return Icons.account_balance;
      case 'shopping':
        return Icons.shopping_cart;
      case 'freelance':
        return Icons.work_outline;
      case 'entertainment':
        return Icons.movie_outlined;
      case 'transfer':
        return Icons.person_outline;
      case 'utilities':
        return Icons.bolt;
      case 'food':
        return Icons.restaurant;
      case 'refund':
        return Icons.replay;
      case 'transport':
        return Icons.local_gas_station;
      case 'health':
        return Icons.fitness_center;
      default:
        return Icons.attach_money;
    }
  }

  // Group transactions by section
  List<dynamic> _buildGroupedList() {
    final List<dynamic> items = [];
    String? lastSection;

    for (final tx in _transactions) {
      final section = tx['section'] as String? ?? 'Other';
      if (section != lastSection) {
        items.add(section);
        lastSection = section;
      }
      items.add(tx);
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
            icon: const Icon(Icons.filter_list_rounded, color: ArgonColors.text, size: 24),
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: ArgonColors.primary))
          : _errorMessage != null
              ? _buildErrorState()
              : _transactions.isEmpty
                  ? _buildEmptyState()
                  : RefreshIndicator(
                      color: ArgonColors.primary,
                      onRefresh: () => _loadData(filter: _activeFilter),
                      child: _buildTransactionList(),
                    ),
    );
  }

  Widget _buildTransactionList() {
    final groupedItems = _buildGroupedList();
    final totalBalance = (_accountData?['totalBalance'] as num?)?.toDouble() ?? 0;
    final percentChange = (_accountData?['percentChange'] as num?)?.toDouble() ?? 0;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: groupedItems.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return FadeTransition(
            opacity: CurvedAnimation(parent: _animController, curve: Curves.easeOut),
            child: Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 4),
              child: BalanceSummary(
                totalBalance: totalBalance,
                percentChange: percentChange,
              ),
            ),
          );
        }

        final item = groupedItems[index - 1];

        if (item is String) {
          return FadeTransition(
            opacity: CurvedAnimation(parent: _animController, curve: Curves.easeOut),
            child: SectionHeader(title: item.toUpperCase()),
          );
        }

        final tx = item as Map<String, dynamic>;
        final isIncome = tx['type'] == 'income';
        final itemIndex = groupedItems.sublist(0, index - 1).whereType<Map>().length;

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
                title: tx['title'] as String,
                date: tx['section'] as String? ?? '',
                amount: (tx['amount'] as num).toDouble(),
                type: isIncome ? TransactionType.income : TransactionType.expense,
                icon: _iconForCategory(tx['category'] as String? ?? ''),
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
          Icon(Icons.receipt_long_outlined, size: 64, color: ArgonColors.muted.withValues(alpha: 0.5)),
          const SizedBox(height: 16),
          const Text('No transactions yet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ArgonColors.text)),
          const SizedBox(height: 8),
          Text(
            _activeFilter != null ? 'No $_activeFilter transactions found' : 'Your transaction history will appear here',
            style: const TextStyle(fontSize: 14, color: ArgonColors.muted),
          ),
          if (_activeFilter != null) ...[
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => _loadData(),
              child: const Text('Show all transactions'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: ArgonColors.error.withValues(alpha: 0.7)),
          const SizedBox(height: 12),
          Text(
            _errorMessage ?? 'Something went wrong',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: ArgonColors.text),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => _loadData(filter: _activeFilter),
            child: const Text('Retry'),
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
                    decoration: BoxDecoration(color: ArgonColors.border, borderRadius: BorderRadius.circular(2)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Filter Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: ArgonColors.text)),
                const SizedBox(height: 16),
                _FilterOption(
                  label: 'All',
                  icon: Icons.list,
                  isActive: _activeFilter == null,
                  onTap: () {
                    Navigator.pop(context);
                    _loadData();
                  },
                ),
                _FilterOption(
                  label: 'Income',
                  icon: Icons.arrow_downward,
                  iconColor: ArgonColors.success,
                  isActive: _activeFilter == 'income',
                  onTap: () {
                    Navigator.pop(context);
                    _loadData(filter: 'income');
                  },
                ),
                _FilterOption(
                  label: 'Expenses',
                  icon: Icons.arrow_upward,
                  iconColor: ArgonColors.error,
                  isActive: _activeFilter == 'expense',
                  onTap: () {
                    Navigator.pop(context);
                    _loadData(filter: 'expense');
                  },
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

class _FilterOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? iconColor;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterOption({
    required this.label,
    required this.icon,
    this.iconColor,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: iconColor ?? ArgonColors.primary),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          color: isActive ? ArgonColors.primary : ArgonColors.text,
        ),
      ),
      trailing: isActive ? const Icon(Icons.check_rounded, color: ArgonColors.primary, size: 20) : null,
      onTap: onTap,
    );
  }
}
