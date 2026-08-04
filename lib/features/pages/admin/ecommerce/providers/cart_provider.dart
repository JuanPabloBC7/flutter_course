import 'package:flutter_course/core/widgets/product_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Item del carrito con producto, cantidad, talla y color seleccionados.
class CartItem {
  final Product product;
  final int quantity;
  final String selectedSize;
  final String selectedColor;

  const CartItem({
    required this.product,
    this.quantity = 1,
    this.selectedSize = 'M',
    this.selectedColor = '#000000',
  });

  CartItem copyWith({
    Product? product,
    int? quantity,
    String? selectedSize,
    String? selectedColor,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }
}

/// Notifier que gestiona el estado del carrito.
class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  /// Agrega un producto al carrito. Si ya existe con la misma talla y color,
  /// incrementa la cantidad.
  void addItem({
    required Product product,
    int quantity = 1,
    String selectedSize = 'M',
    String selectedColor = '#000000',
  }) {
    final existingIndex = state.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.selectedSize == selectedSize &&
          item.selectedColor == selectedColor,
    );

    if (existingIndex >= 0) {
      // Ya existe, incrementar cantidad
      final existing = state[existingIndex];
      final updated = existing.copyWith(quantity: existing.quantity + quantity);
      state = [
        ...state.sublist(0, existingIndex),
        updated,
        ...state.sublist(existingIndex + 1),
      ];
    } else {
      // Nuevo item
      state = [
        ...state,
        CartItem(
          product: product,
          quantity: quantity,
          selectedSize: selectedSize,
          selectedColor: selectedColor,
        ),
      ];
    }
  }

  /// Elimina un item del carrito por índice.
  void removeItem(int index) {
    if (index >= 0 && index < state.length) {
      state = [...state]..removeAt(index);
    }
  }

  /// Limpia todo el carrito.
  void clear() {
    state = [];
  }

  /// Cantidad total de items en el carrito.
  int get totalItems => state.fold(0, (sum, item) => sum + item.quantity);
}

// ── Provider ─────────────────────────────────────────────────────────────────

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

/// Provider derivado para el conteo total de items.
final cartItemCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0, (sum, item) => sum + item.quantity);
});
