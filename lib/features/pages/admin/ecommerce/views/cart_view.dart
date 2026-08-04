import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/features/pages/admin/ecommerce/providers/cart_provider.dart';
import 'package:flutter_course/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Pantalla del carrito de compras.
/// Muestra los productos del carrito, permite eliminar items,
/// y realizar la compra guardando la orden en Firestore.
class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  ConsumerState<CartView> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  bool _isProcessing = false;

  /// Calcula el total del carrito.
  double _calculateTotal(List<CartItem> items) {
    return items.fold(0.0, (total, item) {
      final price = double.tryParse(
            item.product.price.replaceAll(RegExp(r'[^\d.]'), ''),
          ) ??
          0.0;
      return total + (price * item.quantity);
    });
  }

  /// Realiza la compra y guarda la orden en Firestore.
  Future<void> _checkout(List<CartItem> items) async {
    if (items.isEmpty) return;

    setState(() => _isProcessing = true);

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) throw Exception('User not authenticated');

      final total = _calculateTotal(items);

      // Crear documento de la orden en Firestore
      await FirebaseFirestore.instance.collection('orders').add({
        'userId': userId,
        'items': items.map((item) => {
          'productId': item.product.id,
          'name': item.product.name,
          'price': item.product.price,
          'quantity': item.quantity,
          'selectedSize': item.selectedSize,
          'selectedColor': item.selectedColor,
        }).toList(),
        'total': total.toStringAsFixed(2),
        'status': 'completed',
        'date': Timestamp.now(),
      });

      // Limpiar el carrito
      ref.read(cartProvider.notifier).clear();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Order placed successfully!'),
            backgroundColor: ArgonColors.success,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: ArgonColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cartItems = ref.watch(cartProvider);
    final total = _calculateTotal(cartItems);

    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      appBar: AppBar(
        backgroundColor: ArgonColors.white,
        elevation: 0,
        title: Text(
          l10n.cartCount(cartItems.length),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ArgonColors.text,
          ),
        ),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    size: 64,
                    color: ArgonColors.muted,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.emptyCart,
                    style: const TextStyle(
                      fontSize: 16,
                      color: ArgonColors.muted,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Lista de items
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return _CartItemCard(
                        item: item,
                        onRemove: () {
                          ref.read(cartProvider.notifier).removeItem(index);
                        },
                      );
                    },
                  ),
                ),
                // Sección de checkout
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: ArgonColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        // Total
                        Row(
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
                              '\$${total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: ArgonColors.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Botón de compra
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _isProcessing
                                ? null
                                : () => _checkout(cartItems),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ArgonColors.primary,
                              foregroundColor: ArgonColors.white,
                              disabledBackgroundColor:
                                  ArgonColors.primary.withValues(alpha: 0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: _isProcessing
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      color: ArgonColors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Checkout',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

/// Tarjeta individual de un item del carrito.
class _CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;

  const _CartItemCard({
    required this.item,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
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
          // Imagen del producto
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: ArgonColors.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: item.product.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      item.product.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, e, s) => const Icon(
                        Icons.image,
                        color: ArgonColors.muted,
                      ),
                    ),
                  )
                : const Icon(Icons.image, color: ArgonColors.muted),
          ),
          const SizedBox(width: 14),
          // Info del producto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: ArgonColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.product.price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ArgonColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Size: ${item.selectedSize} · Qty: ${item.quantity}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: ArgonColors.muted,
                  ),
                ),
              ],
            ),
          ),
          // Botón eliminar
          IconButton(
            onPressed: onRemove,
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: ArgonColors.error,
            ),
            tooltip: 'Remove',
          ),
        ],
      ),
    );
  }
}
