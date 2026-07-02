import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/l10n/app_localizations.dart';

/// A reusable top bar widget for e-commerce screens with search, favorites, and cart
class EcommerceTopBar extends StatelessWidget {
  /// Callback when search is tapped
  final VoidCallback? onSearchTap;

  /// Callback when favorites/heart is tapped
  final VoidCallback? onFavoriteTap;

  /// Callback when cart is tapped
  final VoidCallback? onCartTap;

  /// Number of items in cart to display as badge
  final int cartItemCount;

  /// Number of items in favorites to display as badge
  final int favoriteItemCount;

  const EcommerceTopBar({
    super.key,
    this.onSearchTap,
    this.onFavoriteTap,
    this.onCartTap,
    this.cartItemCount = 0,
    this.favoriteItemCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Search Field
          Expanded(
            child: GestureDetector(
              onTap: onSearchTap,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: ArgonColors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        size: 20,
                        color: ArgonColors.muted,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.searchProductsPlaceholder,
                        style: const TextStyle(
                          color: ArgonColors.muted,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Heart/Favorites Button
          GestureDetector(
            onTap: onFavoriteTap,
            child: Stack(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: ArgonColors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    size: 20,
                    color: ArgonColors.text,
                  ),
                ),
                if (favoriteItemCount > 0)
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                        color: ArgonColors.label,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          favoriteItemCount.toString(),
                          style: const TextStyle(
                            color: ArgonColors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Cart Button
          GestureDetector(
            onTap: onCartTap,
            child: Stack(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: ArgonColors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    size: 20,
                    color: ArgonColors.text,
                  ),
                ),
                if (cartItemCount > 0)
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                        color: ArgonColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          cartItemCount.toString(),
                          style: const TextStyle(
                            color: ArgonColors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
