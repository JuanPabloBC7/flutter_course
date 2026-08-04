import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/widgets/product_card.dart';
import 'package:flutter_course/features/pages/admin/ecommerce/providers/cart_provider.dart';
import 'package:flutter_course/features/pages/admin/ecommerce/providers/favorites_provider.dart';
import 'package:flutter_course/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Pantalla de productos favoritos.
/// Muestra los productos marcados como favoritos con opción de
/// agregar/quitar del carrito.
class FavoritesView extends ConsumerWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final favorites = ref.watch(favoritesProvider);
    final cart = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      appBar: AppBar(
        backgroundColor: ArgonColors.white,
        elevation: 0,
        title: Text(
          l10n.favoritesCount(favorites.length),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ArgonColors.text,
          ),
        ),
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite_border_rounded,
                    size: 64,
                    color: ArgonColors.muted,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.noFavoritesYet,
                    style: const TextStyle(
                      fontSize: 16,
                      color: ArgonColors.muted,
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final product = favorites[index];
                final isInCart = cart.any((item) => item.product.id == product.id);

                return _FavoriteItemCard(
                  product: product,
                  isInCart: isInCart,
                  onCartToggle: () {
                    if (isInCart) {
                      // Quitar del carrito
                      final cartIndex = cart.indexWhere(
                        (item) => item.product.id == product.id,
                      );
                      ref.read(cartProvider.notifier).removeItem(cartIndex);
                    } else {
                      // Agregar al carrito
                      ref.read(cartProvider.notifier).addItem(product: product);
                    }
                  },
                  onRemoveFavorite: () {
                    ref.read(favoritesProvider.notifier).remove(product.id);
                  },
                );
              },
            ),
    );
  }
}

/// Tarjeta individual de un producto favorito.
class _FavoriteItemCard extends StatelessWidget {
  final Product product;
  final bool isInCart;
  final VoidCallback onCartToggle;
  final VoidCallback onRemoveFavorite;

  const _FavoriteItemCard({
    required this.product,
    required this.isInCart,
    required this.onCartToggle,
    required this.onRemoveFavorite,
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
            child: product.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product.imageUrl!,
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
                  product.name,
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
                  product.price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ArgonColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Botón agregar/quitar del carrito
          IconButton(
            onPressed: onCartToggle,
            icon: Icon(
              isInCart ? Icons.shopping_bag : Icons.shopping_bag_outlined,
              color: isInCart ? ArgonColors.primary : ArgonColors.muted,
            ),
            tooltip: isInCart ? 'Remove from cart' : 'Add to cart',
          ),
          // Botón quitar de favoritos
          IconButton(
            onPressed: onRemoveFavorite,
            icon: const Icon(
              Icons.favorite,
              color: ArgonColors.label,
            ),
            tooltip: 'Remove from favorites',
          ),
        ],
      ),
    );
  }
}
