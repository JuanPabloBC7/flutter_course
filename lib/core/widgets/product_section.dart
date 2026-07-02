import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/widgets/product_card.dart';
import 'package:flutter_course/l10n/app_localizations.dart';

/// A reusable section widget that displays a horizontal scrollable list of products with a title and "See more" button
class ProductSection extends StatelessWidget {
  /// Title of the section
  final String title;

  /// List of products to display
  final List<Product> products;

  /// Callback when "See more" is tapped
  final VoidCallback? onSeeMore;

  /// Callback when a product is tapped
  final Function(Product)? onProductTap;

  /// Callback when a product is liked
  final Function(Product, bool)? onProductLike;

  /// Map of product IDs to liked status
  final Map<String, bool> likedProducts;

  /// Height of the product card
  final double cardHeight;

  /// Whether to show the "See more" button
  final bool showSeeMore;

  const ProductSection({
    super.key,
    required this.title,
    required this.products,
    this.onSeeMore,
    this.onProductTap,
    this.onProductLike,
    this.likedProducts = const {},
    this.cardHeight = 220,
    this.showSeeMore = true,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header with Title and See More
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: ArgonColors.text,
                ),
              ),
              if (showSeeMore)
                GestureDetector(
                  onTap: onSeeMore,
                  child: Text(
                    l10n.seeMore,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ArgonColors.primary,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Products Horizontal Carousel/List
        SizedBox(
          height: cardHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final isLiked = likedProducts[product.id] ?? false;

              return Padding(
                padding: EdgeInsets.only(right: index == products.length - 1 ? 0 : 12),
                child: ProductCard(
                  product: product,
                  isLiked: isLiked,
                  width: 160,
                  onTap: () => onProductTap?.call(product),
                  onLikeTap: () {
                    onProductLike?.call(product, !isLiked);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
