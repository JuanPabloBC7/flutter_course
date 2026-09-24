import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/features/pages/admin/ecommerce/services/order_firestore_service.dart';
import 'package:flutter_course/l10n/app_localizations.dart';

/// Pantalla que carga una orden por su ID y muestra su detalle.
/// Usada cuando se navega desde una notificación (solo se tiene el orderId).
class OrderDetailLoader extends StatelessWidget {
  final String orderId;

  const OrderDetailLoader({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: OrderFirestoreService().fetchOrderById(orderId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: ArgonColors.bgColorScreen,
            body: Center(
              child: CircularProgressIndicator(color: ArgonColors.primary),
            ),
          );
        }

        final order = snapshot.data;
        if (order == null) {
          return Scaffold(
            backgroundColor: ArgonColors.bgColorScreen,
            appBar: AppBar(backgroundColor: ArgonColors.white, elevation: 0),
            body: const Center(child: Text('Order not found')),
          );
        }

        return OrderDetailView(order: order);
      },
    );
  }
}

/// Pantalla de detalle de una orden de compra.
/// Muestra el listado completo de productos, total, fecha, estado, etc.
class OrderDetailView extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailView({super.key, required this.order});

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

  /// Formatea la fecha con hora.
  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '${date.day} ${months[date.month - 1]} ${date.year} · $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final status = order['status'] as String;
    final total = order['total'] as String;
    final itemCount = order['itemCount'] as int;
    final date = order['date'] as DateTime;
    final docId = order['docId'] as String;
    final items = order['items'] as List<Map<String, dynamic>>;
    final statusColor = _statusColor(status);

    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      appBar: AppBar(
        backgroundColor: ArgonColors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          l10n.orderDetailTitle,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ArgonColors.text,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Card de resumen (estado, fecha, orden ID) ──
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ArgonColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // Icono + estado
                Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: ArgonColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.shopping_bag_rounded,
                        color: ArgonColors.primary,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.orderNumber(docId.substring(0, docId.length > 8 ? 8 : docId.length)),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: ArgonColors.text,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$itemCount ${itemCount == 1 ? 'item' : 'items'}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: ArgonColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status[0].toUpperCase() + status.substring(1),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(color: ArgonColors.border.withValues(alpha: 0.5), height: 1),
                const SizedBox(height: 14),
                // Fecha
                _InfoRow(
                  icon: Icons.calendar_today_rounded,
                  label: l10n.orderDate,
                  value: _formatDate(date),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Sección de productos ──
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 10),
            child: Text(
              l10n.orderProducts,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: ArgonColors.muted,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Container(
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
            child: Column(
              children: List.generate(items.length, (index) {
                final item = items[index];
                final name = item['name'] as String? ?? '';
                final quantity = item['quantity'] as int? ?? 1;
                final price = item['price'] as String? ?? '';
                final size = item['selectedSize'] as String? ?? '';

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          // Cantidad
                          Container(
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ArgonColors.bgColorScreen,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${quantity}x',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: ArgonColors.text,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Nombre + talla
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: ArgonColors.text,
                                  ),
                                ),
                                if (size.isNotEmpty) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    'Size: $size',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: ArgonColors.muted,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          // Precio
                          Text(
                            price,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: ArgonColors.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (index < items.length - 1)
                      Divider(
                        height: 1,
                        indent: 14,
                        endIndent: 14,
                        color: ArgonColors.border.withValues(alpha: 0.5),
                      ),
                  ],
                );
              }),
            ),
          ),

          const SizedBox(height: 20),

          // ── Card de total ──
          Container(
            padding: const EdgeInsets.all(20),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ArgonColors.text,
                  ),
                ),
                Text(
                  '\$$total',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: ArgonColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

/// Fila de información con icono, label y valor.
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: ArgonColors.muted),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: ArgonColors.muted,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: ArgonColors.text,
          ),
        ),
      ],
    );
  }
}
