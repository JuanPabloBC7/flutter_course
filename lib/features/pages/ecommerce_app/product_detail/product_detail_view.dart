import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/widgets/color_selector.dart';
import 'package:flutter_course/core/widgets/product_card.dart';
import 'package:flutter_course/core/widgets/product_detail_image_carousel.dart';
import 'package:flutter_course/core/widgets/size_selector.dart';
import 'package:flutter_course/features/pages/ecommerce_app/product_detail/providers/product_detail_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductDetailView extends ConsumerWidget {
  final Product product;

  const ProductDetailView({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(productDetailProvider(product));

    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image Carousel
              ProductDetailImageCarousel(
                images: [
                  product.imageUrl ?? '',
                  product.imageUrl ?? '',
                  product.imageUrl ?? '',
                ],
                onClose: () => context.pop(),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with Title and Favorite
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: ArgonColors.text,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                product.price,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: ArgonColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            ref
                                .read(productDetailProvider(product).notifier)
                                .toggleFavorite();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ArgonColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Icon(
                              detailState.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 24,
                              color: detailState.isFavorite
                                  ? ArgonColors.label
                                  : ArgonColors.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Description
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: ArgonColors.text,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'The perfect T-shirt for when you want to feel comfortable but still stylish. Amazing for all occasions. Made of 100% cotton fabric in your colours. Its modern style gives a lighter look to the outfit. Perfect for the warmest days.',
                      style: TextStyle(
                        fontSize: 14,
                        color: ArgonColors.header,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Size Selector
                    SizeSelector(
                      selectedSize: detailState.selectedSize,
                      onSizeSelected: (size) {
                        ref
                            .read(productDetailProvider(product).notifier)
                            .selectSize(size);
                      },
                    ),
                    const SizedBox(height: 24),
                    // Color Selector
                    ColorSelector(
                      selectedColor: detailState.selectedColor,
                      onColorSelected: (colorHex, color) {
                        ref
                            .read(productDetailProvider(product).notifier)
                            .selectColor(colorHex);
                      },
                    ),
                    const SizedBox(height: 32),
                    // Add to Bag Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ref
                              .read(productDetailProvider(product).notifier)
                              .addToCart();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${product.name} added to cart!',
                              ),
                              backgroundColor: ArgonColors.success,
                              duration: const Duration(milliseconds: 1500),
                            ),
                          );
                        },
                        icon: const Icon(Icons.shopping_bag_outlined),
                        label: const Text('Add to bag'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ArgonColors.primary,
                          foregroundColor: ArgonColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
