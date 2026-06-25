import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/routing/app_router.dart';
import 'package:flutter_course/core/widgets/ecommerce_top_bar.dart';
import 'package:flutter_course/core/widgets/image_carousel.dart';
import 'package:flutter_course/core/widgets/product_card.dart';
import 'package:flutter_course/core/widgets/product_section.dart';
import 'package:flutter_course/features/pages/admin/ecommerce/providers/ecommerce_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EcommerceView extends ConsumerStatefulWidget {
  const EcommerceView({super.key});

  @override
  ConsumerState<EcommerceView> createState() => _EcommerceViewState();
}

class _EcommerceViewState extends ConsumerState<EcommerceView> {
  final List<String> carouselImages = ['', '', ''];

  Map<String, bool> likedProducts = {};
  int cartItemCount = 0;
  int favoriteItemCount = 0;

  void _handleProductLike(Product product, bool isLiked) {
    setState(() {
      likedProducts[product.id] = isLiked;
      if (isLiked) {
        favoriteItemCount++;
      } else if (favoriteItemCount > 0) {
        favoriteItemCount--;
      }
    });
  }

  void _handleProductTap(Product product) {
    context.push(
      '/product-detail',
      extra: product,
    );
  }

  void _handleSeeMore(String section) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('See more tapped for $section')),
    );
  }

  void _handleSearchTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Search tapped')),
    );
  }

  void _handleFavoriteTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Favorites - $favoriteItemCount items'),
      ),
    );
  }

  void _handleCartTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cart - $cartItemCount items'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final perfectForYouAsync = ref.watch(perfectForYouProductsProvider);
    final forThisSummerAsync = ref.watch(forThisSummerProductsProvider);

    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      appBar: AppBar(
        backgroundColor: ArgonColors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: ArgonColors.text),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRouter.dashboard);
            }
          },
        ),
        title: const Text(
          'E-Commerce',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ArgonColors.text,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Bar with Search, Favorites, and Cart
            EcommerceTopBar(
              cartItemCount: cartItemCount,
              favoriteItemCount: favoriteItemCount,
              onSearchTap: _handleSearchTap,
              onFavoriteTap: _handleFavoriteTap,
              onCartTap: _handleCartTap,
            ),
            const SizedBox(height: 16),
            // Image Carousel
            ImageCarousel(
              images: carouselImages,
              height: 200,
            ),
            const SizedBox(height: 32),
            // Perfect for you section - Horizontal Carousel
            perfectForYouAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator(color: ArgonColors.primary)),
              ),
              error: (error, _) => Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Error loading products: $error', style: const TextStyle(color: ArgonColors.error)),
              ),
              data: (products) => ProductSection(
                title: 'Perfect for you',
                products: products,
                likedProducts: likedProducts,
                onProductTap: _handleProductTap,
                onProductLike: _handleProductLike,
                onSeeMore: () => _handleSeeMore('Perfect for you'),
              ),
            ),
            const SizedBox(height: 32),

            // For this summer section
            forThisSummerAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator(color: ArgonColors.primary)),
              ),
              error: (error, _) => Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Error loading products: $error', style: const TextStyle(color: ArgonColors.error)),
              ),
              data: (products) => ProductSection(
                title: 'For this summer',
                products: products,
                likedProducts: likedProducts,
                onProductTap: _handleProductTap,
                onProductLike: _handleProductLike,
                onSeeMore: () => _handleSeeMore('For this summer'),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ArgonColors.white,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        selectedItemColor: ArgonColors.primary,
        unselectedItemColor: ArgonColors.muted,
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}
