import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_course/core/widgets/product_card.dart';

/// Service to fetch products from the Firestore "products" collection.
///
/// Collection structure:
/// products/
///   {documentId}/
///     - name: String
///     - price: String
///     - imageUrl: String
///     - category: String ("perfect_for_you" | "for_this_summer")
class ProductFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _collection = 'products';

  /// Fetches all products from Firestore.
  Future<List<Product>> fetchAllProducts() async {
    final snapshot = await _firestore.collection(_collection).get();
    print('JPBALAN');
    print(snapshot);

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Product(
        id: doc.id,
        name: data['name'] as String? ?? '',
        price: data['price'] as String? ?? '',
        imageUrl: data['imageUrl'] as String?,
      );
    }).toList();
  }

  /// Fetches products filtered by category.
  Future<List<Product>> fetchProductsByCategory(String category) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('category', isEqualTo: category)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Product(
        id: doc.id,
        name: data['name'] as String? ?? '',
        price: data['price'] as String? ?? '',
        imageUrl: data['imageUrl'] as String?,
      );
    }).toList();
  }

  /// Fetches "Perfect for you" products.
  Future<List<Product>> fetchPerfectForYou() async {
    return fetchProductsByCategory('perfect_for_you');
  }

  /// Fetches "For this summer" products.
  Future<List<Product>> fetchForThisSummer() async {
    return fetchProductsByCategory('for_this_summer');
  }

  /// Actualiza un producto en Firestore (solo admin).
  Future<void> updateProduct({
    required String productId,
    required String name,
    required String price,
    String? imageUrl,
    String? category,
  }) async {
    final data = <String, dynamic>{
      'name': name,
      'price': price,
    };
    if (imageUrl != null) data['imageUrl'] = imageUrl;
    if (category != null) data['category'] = category;

    await _firestore.collection(_collection).doc(productId).update(data);
  }
}
