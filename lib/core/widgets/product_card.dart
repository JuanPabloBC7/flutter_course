import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';

/// Data class for product information
class Product {
  final String id;
  final String name;
  final String price;
  final String? imageUrl;
  final String? imageAsset;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl,
    this.imageAsset,
  });
}

/// A reusable product card widget
class ProductCard extends StatelessWidget {
  /// Product data to display
  final Product product;

  /// Callback when card is tapped
  final VoidCallback? onTap;

  /// Callback when like button is tapped
  final VoidCallback? onLikeTap;

  /// Whether the product is liked
  final bool isLiked;

  /// Width of the card
  final double width;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onLikeTap,
    this.isLiked = false,
    this.width = 160,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ArgonColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  color: ArgonColors.secondary,
                ),
                child: Stack(
                  children: [
                    // Image
                    if (product.imageUrl != null)
                      Image.network(
                        product.imageUrl!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.image,
                              size: 48,
                              color: ArgonColors.muted,
                            ),
                          );
                        },
                      )
                    else if (product.imageAsset != null)
                      Image.asset(
                        product.imageAsset!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.image,
                              size: 48,
                              color: ArgonColors.muted,
                            ),
                          );
                        },
                      )
                    else
                      const Center(
                        child: Icon(
                          Icons.image,
                          size: 48,
                          color: ArgonColors.muted,
                        ),
                      ),
                    // Like button
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: onLikeTap,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ArgonColors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            size: 18,
                            color:
                                isLiked ? ArgonColors.label : ArgonColors.text,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Product Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ArgonColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Product Price
                  Text(
                    product.price,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ArgonColors.text,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
