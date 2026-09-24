import 'package:flutter_course/features/pages/admin/ecommerce/services/order_firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider del servicio de órdenes.
final orderFirestoreServiceProvider =
    Provider<OrderFirestoreService>((ref) => OrderFirestoreService());

/// Provider que obtiene el historial de órdenes del usuario.
final salesHistoryProvider =
    FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final service = ref.read(orderFirestoreServiceProvider);
  return service.fetchUserOrders();
});
