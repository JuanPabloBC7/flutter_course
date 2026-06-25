import 'package:flutter_course/core/widgets/product_card.dart';
import 'package:flutter_course/features/pages/admin/ecommerce/services/product_firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productFirestoreServiceProvider = Provider<ProductFirestoreService>((ref) {
  return ProductFirestoreService();
});

/// Provider for "Perfect for you" products from Firestore.
final perfectForYouProductsProvider = FutureProvider<List<Product>>((ref) async {
  final service = ref.read(productFirestoreServiceProvider);
  return service.fetchPerfectForYou();
});

/// Provider for "For this summer" products from Firestore.
final forThisSummerProductsProvider = FutureProvider<List<Product>>((ref) async {
  final service = ref.read(productFirestoreServiceProvider);
  return service.fetchForThisSummer();
});
