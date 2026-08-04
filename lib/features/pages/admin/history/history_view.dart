import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/utils/category_icon.dart';
import 'package:flutter_course/core/widgets/balance_summary.dart';
import 'package:flutter_course/core/widgets/empty_state.dart';
import 'package:flutter_course/core/widgets/error_state.dart';
import 'package:flutter_course/core/widgets/section_header.dart';
import 'package:flutter_course/core/widgets/transaction_card.dart';
import 'package:flutter_course/features/pages/admin/history/providers/history_providers.dart';
import 'package:flutter_course/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryView extends ConsumerStatefulWidget {
  const HistoryView({super.key});

  @override
  ConsumerState<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends ConsumerState<HistoryView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _animController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Detecta cuando el usuario llega al final de la lista para cargar más.
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(historyTransactionsProvider.notifier).loadNextPage();
    }
  }

  List<dynamic> _buildGroupedList(List<Map<String, dynamic>> transactions) {
    final List<dynamic> items = [];
    String? lastSection;

    for (final tx in transactions) {
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
    final l10n = AppLocalizations.of(context)!;
    final historyAsync = ref.watch(historyTransactionsProvider);
    final accountAsync = ref.watch(historyAccountProvider);
    final activeFilter = ref.watch(historyFilterProvider);

    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      appBar: AppBar(
        backgroundColor: ArgonColors.white,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          l10n.historyTitle,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: ArgonColors.text),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: ArgonColors.text, size: 24),
            onPressed: () => _showFilterSheet(context, activeFilter),
          ),
        ],
      ),
      body: historyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: ArgonColors.primary)),
        error: (error, _) => ErrorState(
          message: error.toString(),
          onRetry: () => ref.read(historyTransactionsProvider.notifier).refresh(),
        ),
        data: (historyState) {
          final transactions = historyState.transactions;

          if (transactions.isEmpty && !historyState.isLoadingMore) {
            return EmptyState(
              icon: Icons.receipt_long_outlined,
              title: l10n.noTransactionsYet,
              subtitle: activeFilter != null ? l10n.noFilteredTransactions(activeFilter) : l10n.transactionHistoryWillAppear,
              actionLabel: activeFilter != null ? l10n.showAllTransactions : null,
              onAction: activeFilter != null ? () => ref.read(historyFilterProvider.notifier).state = null : null,
            );
          }

          if (!_animController.isAnimating && _animController.status != AnimationStatus.completed) {
            _animController.forward(from: 0);
          }

          final totalBalance = accountAsync.valueOrNull?['totalBalance'] as num? ?? 0;
          final percentChange = accountAsync.valueOrNull?['percentChange'] as num? ?? 0;

          return RefreshIndicator(
            color: ArgonColors.primary,
            onRefresh: () async {
              ref.read(historyTransactionsProvider.notifier).refresh();
              ref.invalidate(historyAccountProvider);
            },
            child: _buildTransactionList(
              transactions,
              totalBalance.toDouble(),
              percentChange.toDouble(),
              historyState.hasMore,
              historyState.isLoadingMore,
            ),
          );
        },
      ),
    );
  }

  Widget _buildTransactionList(
    List<Map<String, dynamic>> transactions,
    double totalBalance,
    double percentChange,
    bool hasMore,
    bool isLoadingMore,
  ) {
    final groupedItems = _buildGroupedList(transactions);

    // +1 para el balance header, +1 para el indicador de carga al final
    final itemCount = groupedItems.length + 1 + (hasMore || isLoadingMore ? 1 : 0);

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        // Primer item: Balance summary
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

        // Último item: indicador de carga para paginación
        if (index == itemCount - 1 && (hasMore || isLoadingMore)) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: isLoadingMore
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: ArgonColors.primary,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          );
        }

        final item = groupedItems[index - 1];

        // Encabezado de sección (Today, Yesterday, etc.)
        if (item is String) {
          return FadeTransition(
            opacity: CurvedAnimation(parent: _animController, curve: Curves.easeOut),
            child: SectionHeader(title: item.toUpperCase()),
          );
        }

        // Tarjeta de transacción
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
                icon: CategoryIcon.fromCategory(tx['category'] as String? ?? ''),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showFilterSheet(BuildContext context, String? activeFilter) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ArgonColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
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
                Text(l10n.filterTransactions, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: ArgonColors.text)),
                const SizedBox(height: 16),
                _FilterOption(label: l10n.filterAll, icon: Icons.list, isActive: activeFilter == null, onTap: () { Navigator.pop(context); ref.read(historyFilterProvider.notifier).state = null; }),
                _FilterOption(label: l10n.filterIncome, icon: Icons.arrow_downward, iconColor: ArgonColors.success, isActive: activeFilter == 'income', onTap: () { Navigator.pop(context); ref.read(historyFilterProvider.notifier).state = 'income'; }),
                _FilterOption(label: l10n.filterExpenses, icon: Icons.arrow_upward, iconColor: ArgonColors.error, isActive: activeFilter == 'expense', onTap: () { Navigator.pop(context); ref.read(historyFilterProvider.notifier).state = 'expense'; }),
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

  const _FilterOption({required this.label, required this.icon, this.iconColor, this.isActive = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: iconColor ?? ArgonColors.primary),
      title: Text(label, style: TextStyle(fontSize: 15, fontWeight: isActive ? FontWeight.w700 : FontWeight.w500, color: isActive ? ArgonColors.primary : ArgonColors.text)),
      trailing: isActive ? const Icon(Icons.check_rounded, color: ArgonColors.primary, size: 20) : null,
      onTap: onTap,
    );
  }
}
