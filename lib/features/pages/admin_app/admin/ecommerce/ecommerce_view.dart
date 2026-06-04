import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/widgets/ecommerce_top_bar.dart';
import 'package:flutter_course/core/widgets/image_carousel.dart';
import 'package:flutter_course/core/widgets/product_card.dart';
import 'package:flutter_course/core/widgets/product_section.dart';
import 'package:flutter_course/features/pages/admin_app/admin/product_detail/product_detail_view.dart';
import 'package:go_router/go_router.dart';

class EcommerceView extends StatefulWidget {
  const EcommerceView({super.key});

  @override
  State<EcommerceView> createState() => _EcommerceViewState();
}

class _EcommerceViewState extends State<EcommerceView> {
  // Sample carousel images
  final List<String> carouselImages = [
    '',
    '',
    '',
  ];

  // Sample products for "Perfect for you" section
  final List<Product> perfectForYouProducts = [
    Product(
      id: '1',
      name: 'Amazing T-shirt',
      price: '€ 12.00',
      imageUrl:
          '',
    ),
    Product(
      id: '2',
      name: 'Fabulous Pants',
      price: '€ 15.00',
      imageUrl:
          '',
    ),
    Product(
      id: '5',
      name: 'Classic Jacket',
      price: '€ 45.00',
      imageUrl:
          '',
    ),
    Product(
      id: '6',
      name: 'Trendy Sneakers',
      price: '€ 80.00',
      imageUrl:
          '',
    ),
  ];

  // Sample products for "For this summer" section
  final List<Product> forThisSummerProducts = [
    Product(
      id: '3',
      name: 'Summer Dress',
      price: '€ 25.00',
      imageUrl:
          '',
    ),
    Product(
      id: '4',
      name: 'Beach Hat',
      price: '€ 18.00',
      imageUrl:
          '',
    ),
    Product(
      id: '7',
      name: 'Sunglasses',
      price: '€ 35.00',
      imageUrl:
          '',
    ),
    Product(
      id: '8',
      name: 'Beach Bag',
      price: '€ 42.00',
      imageUrl:
          '',
    ),
  ];

  // Track liked products and cart
  late Map<String, bool> likedProducts = {};
  int cartItemCount = 0;
  int favoriteItemCount = 0;

  @override
  void initState() {
    super.initState();
    // Initialize liked products
    for (final product in perfectForYouProducts) {
      likedProducts[product.id] = false;
    }
    for (final product in forThisSummerProducts) {
      likedProducts[product.id] = false;
    }
  }

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
      extra: ProductDetailView(product: product),
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
    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      appBar: AppBar(
        backgroundColor: ArgonColors.white,
        elevation: 0,
        centerTitle: false,
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
            ProductSection(
              title: 'Perfect for you',
              products: perfectForYouProducts,
              likedProducts: likedProducts,
              onProductTap: _handleProductTap,
              onProductLike: _handleProductLike,
              onSeeMore: () => _handleSeeMore('Perfect for you'),
            ),
            const SizedBox(height: 32),
            // For this summer section - Horizontal Carousel
            ProductSection(
              title: 'For this summer',
              products: forThisSummerProducts,
              likedProducts: likedProducts,
              onProductTap: _handleProductTap,
              onProductLike: _handleProductLike,
              onSeeMore: () => _handleSeeMore('For this summer'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      // Bottom Navigation Bar
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
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Stores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: ArgonColors.primary,
        unselectedItemColor: ArgonColors.muted,
      ),
    );
  }
}
