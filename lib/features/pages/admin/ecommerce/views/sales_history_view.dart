import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/widgets/empty_state.dart';
import 'package:flutter_course/core/widgets/error_state.dart';
import 'package:flutter_course/features/pages/admin/ecommerce/providers/sales_history_provider.dart';
import 'package:flutter_course/features/pages/admin/ecommerce/views/order_detail_view.dart';
import 'package:flutter_course/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Pantalla de historial de compras (órdenes) del usuario.
/// Muestra una lista simplificada. Al tocar una orden abre el detalle.
class SalesHistoryView extends ConsumerStatefulWidget {
  const SalesHistoryView({super.key});

  @override
  ConsumerState<SalesHistoryView> createState() => _SalesHistoryViewState();
}

class _SalesHistoryViewState extends ConsumerState<SalesHistoryView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  /// Formatea la fecha en un texto corto y legible.
  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ordersAsync = ref.watch(salesHistoryProvider);

    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      appBar: AppBar(
        backgroundColor: ArgonColors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          l10n.salesHistoryTitle,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ArgonColors.text,
          ),
        ),
      ),
      body: ordersAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: ArgonColors.primary),
        ),
        error: (error, _) => ErrorState(
          message: error.toString(),
          onRetry: () => ref.invalidate(salesHistoryProvider),
        ),
        data: (orders) {
          if (orders.isEmpty) {
            return EmptyState(
              icon: Icons.receipt_long_outlined,
              title: l10n.noOrdersYet,
              subtitle: l10n.ordersWillAppear,
            );
          }

          _animController.forward(from: 0);

          return RefreshIndicator(
            color: ArgonColors.primary,
            onRefresh: () async => ref.invalidate(salesHistoryProvider),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final order = orders[index];
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.15),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: _animController,
                    curve: Interval(
                      (index * 0.08).clamp(0.0, 0.7),
                      ((index * 0.08) + 0.4).clamp(0.0, 1.0),
                      curve: Curves.easeOutCubic,
                    ),
                  )),
                  child: FadeTransition(
                    opacity: CurvedAnimation(
                      parent: _animController,
                      curve: Interval(
                        (index * 0.08).clamp(0.0, 0.7),
                        ((index * 0.08) + 0.4).clamp(0.0, 1.0),
                        curve: Curves.easeOut,
                      ),
                    ),
                    child: _OrderListItem(
                      order: order,
                      dateLabel: _formatDate(order['date'] as DateTime),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OrderDetailView(order: order),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/// Tarjeta compacta de una orden en la lista.
class _OrderListItem extends StatelessWidget {
  final Map<String, dynamic> order;
  final String dateLabel;
  final VoidCallback onTap;

  const _OrderListItem({
    required this.order,
    required this.dateLabel,
    required this.onTap,
  });

  /// Retorna el color según el estado de la orden.
  Color _statusColor(String status) {
    switch (status) {
      case 'completed':
        return ArgonColors.success;
      case 'pending':
        return ArgonColors.warning;
      case 'cancelled':
        return ArgonColors.error;
      default:
        return ArgonColors.muted;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = order['status'] as String;
    final total = order['total'] as String;
    final itemCount = order['itemCount'] as int;
    final statusColor = _statusColor(status);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: ArgonColors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icono
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: ArgonColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.shopping_bag_rounded,
                  color: ArgonColors.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              // Fecha + items
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dateLabel,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: ArgonColors.text,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Text(
                          '$itemCount ${itemCount == 1 ? 'item' : 'items'}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: ArgonColors.muted,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: ArgonColors.muted,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          status[0].toUpperCase() + status.substring(1),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Total + chevron
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$$total',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ArgonColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: ArgonColors.muted,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
