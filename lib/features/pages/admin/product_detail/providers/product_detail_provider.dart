import 'package:flutter_course/core/widgets/product_card.dart';
import 'package:flutter_course/features/pages/admin/ecommerce/providers/cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State for product detail
class ProductDetailState {
  final Product product;
  final bool isFavorite;
  final String selectedSize;
  final String selectedColor;
  final int quantity;

  ProductDetailState({
    required this.product,
    this.isFavorite = false,
    this.selectedSize = 'M',
    this.selectedColor = '#000000',
    this.quantity = 1,
  });

  ProductDetailState copyWith({
    Product? product,
    bool? isFavorite,
    String? selectedSize,
    String? selectedColor,
    int? quantity,
  }) {
    return ProductDetailState(
      product: product ?? this.product,
      isFavorite: isFavorite ?? this.isFavorite,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      quantity: quantity ?? this.quantity,
    );
  }
}

/// Notifier for product detail state
class ProductDetailNotifier extends StateNotifier<ProductDetailState> {
  final CartNotifier _cartNotifier;

  ProductDetailNotifier(Product product, this._cartNotifier)
      : super(ProductDetailState(product: product));

  void toggleFavorite() {
    state = state.copyWith(isFavorite: !state.isFavorite);
  }

  void selectSize(String size) {
    state = state.copyWith(selectedSize: size);
  }

  void selectColor(String color) {
    state = state.copyWith(selectedColor: color);
  }

  void updateQuantity(int quantity) {
    if (quantity > 0) {
      state = state.copyWith(quantity: quantity);
    }
  }

  /// Agrega el producto al carrito con la talla, color y cantidad seleccionados.
  void addToCart() {
    _cartNotifier.addItem(
      product: state.product,
      quantity: state.quantity,
      selectedSize: state.selectedSize,
      selectedColor: state.selectedColor,
    );
  }
}

/// Provider for current selected product (passed via constructor)
final selectedProductProvider =
    StateProvider<Product?>((ref) => null);

/// Provider for product detail state
final productDetailProvider =
    StateNotifierProvider.family<ProductDetailNotifier, ProductDetailState, Product>(
  (ref, product) => ProductDetailNotifier(
    product,
    ref.read(cartProvider.notifier),
  ),
);
