import 'package:flutter_course/core/widgets/product_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier que gestiona el estado de los productos favoritos.
class FavoritesNotifier extends StateNotifier<List<Product>> {
  FavoritesNotifier() : super([]);

  /// Agrega o quita un producto de favoritos.
  void toggle(Product product) {
    final exists = state.any((p) => p.id == product.id);
    if (exists) {
      state = state.where((p) => p.id != product.id).toList();
    } else {
      state = [...state, product];
    }
  }

  /// Verifica si un producto está en favoritos.
  bool isFavorite(String productId) {
    return state.any((p) => p.id == productId);
  }

  /// Elimina un producto de favoritos por ID.
  void remove(String productId) {
    state = state.where((p) => p.id != productId).toList();
  }
}

// ── Provider ─────────────────────────────────────────────────────────────────

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Product>>((ref) {
  return FavoritesNotifier();
});

/// Provider derivado para el conteo de favoritos.
final favoriteCountProvider = Provider<int>((ref) {
  return ref.watch(favoritesProvider).length;
});
