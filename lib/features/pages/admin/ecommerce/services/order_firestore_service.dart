import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Servicio para consultar las órdenes de compra del usuario desde Firestore.
///
/// Estructura de la colección:
/// orders/
///   {documentId}/
///     - userId: String
///     - items: List<Map> (productId, name, price, quantity, selectedSize, selectedColor)
///     - total: String
///     - status: String
///     - date: Timestamp
class OrderFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _collection = 'orders';

  /// Obtiene todas las órdenes del usuario actual, ordenadas por fecha.
  Future<List<Map<String, dynamic>>> fetchUserOrders() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final snapshot = await _firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true)
        .get();

    return snapshot.docs.map((doc) => _mapOrder(doc.id, doc.data())).toList();
  }

  /// Obtiene una orden específica por su ID de documento.
  Future<Map<String, dynamic>?> fetchOrderById(String orderId) async {
    final doc = await _firestore.collection(_collection).doc(orderId).get();
    if (!doc.exists) return null;
    return _mapOrder(doc.id, doc.data()!);
  }

  /// Mapea un documento de Firestore al formato usado por la UI.
  Map<String, dynamic> _mapOrder(String id, Map<String, dynamic> data) {
    final timestamp = data['date'] as Timestamp?;
    final date = timestamp?.toDate() ?? DateTime.now();

    final items = (data['items'] as List<dynamic>? ?? [])
        .map((e) => e as Map<String, dynamic>)
        .toList();

    return {
      'docId': id,
      'total': data['total'] as String? ?? '0.00',
      'status': data['status'] as String? ?? 'completed',
      'date': date,
      'itemCount': items.length,
      'items': items,
    };
  }
}
