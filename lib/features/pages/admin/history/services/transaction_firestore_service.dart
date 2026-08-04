import 'package:cloud_firestore/cloud_firestore.dart';

/// Servicio para consultar transacciones desde Firestore con paginación.
///
/// Estructura de la colección:
/// transactions/
///   {documentId}/
///     - accountId: String
///     - title: String
///     - amount: String
///     - type: String ("income" | "expense")
///     - category: String
///     - date: Timestamp
class TransactionFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _collection = 'transactions';
  static const int _pageSize = 10;

  /// Obtiene la primera página de transacciones para una cuenta específica.
  /// Opcionalmente filtra por tipo (income/expense).
  Future<TransactionPage> fetchFirstPage({
    required String accountId,
    String? filter,
  }) async {
    Query query;

    if (filter != null) {
      query = _firestore
          .collection(_collection)
          .where('accountId', isEqualTo: accountId)
          .where('type', isEqualTo: filter)
          .orderBy('date', descending: true)
          .limit(_pageSize);
    } else {
      query = _firestore
          .collection(_collection)
          .where('accountId', isEqualTo: accountId)
          .orderBy('date', descending: true)
          .limit(_pageSize);
    }

    final snapshot = await query.get();

    final transactions = _mapSnapshot(snapshot);
    final lastDocument = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
    final hasMore = snapshot.docs.length == _pageSize;

    return TransactionPage(
      transactions: transactions,
      lastDocument: lastDocument,
      hasMore: hasMore,
    );
  }

  /// Obtiene la siguiente página de transacciones a partir del último documento.
  Future<TransactionPage> fetchNextPage({
    required String accountId,
    required DocumentSnapshot lastDocument,
    String? filter,
  }) async {
    Query query;

    if (filter != null) {
      query = _firestore
          .collection(_collection)
          .where('accountId', isEqualTo: accountId)
          .where('type', isEqualTo: filter)
          .orderBy('date', descending: true)
          .startAfterDocument(lastDocument)
          .limit(_pageSize);
    } else {
      query = _firestore
          .collection(_collection)
          .where('accountId', isEqualTo: accountId)
          .orderBy('date', descending: true)
          .startAfterDocument(lastDocument)
          .limit(_pageSize);
    }

    final snapshot = await query.get();

    final transactions = _mapSnapshot(snapshot);
    final newLastDocument = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
    final hasMore = snapshot.docs.length == _pageSize;

    return TransactionPage(
      transactions: transactions,
      lastDocument: newLastDocument,
      hasMore: hasMore,
    );
  }

  /// Mapea el snapshot de Firestore a una lista de Maps para la UI.
  List<Map<String, dynamic>> _mapSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final timestamp = data['date'] as Timestamp?;
      final date = timestamp?.toDate() ?? DateTime.now();

      // El amount viene como String desde Firestore
      final amountRaw = data['amount'];
      final amount = amountRaw is num
          ? amountRaw.toDouble()
          : double.tryParse(amountRaw?.toString() ?? '0') ?? 0.0;

      return {
        'docId': doc.id,
        'title': data['title'] as String? ?? '',
        'amount': amount,
        'type': data['type'] as String? ?? 'expense',
        'category': data['category'] as String? ?? '',
        'date': date.toIso8601String(),
        'section': _getSection(date),
      };
    }).toList();
  }

  /// Calcula la sección temporal (Today, Yesterday, This Week, etc.)
  String _getSection(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final weekAgo = today.subtract(const Duration(days: 7));

    final txDate = DateTime(date.year, date.month, date.day);

    if (txDate == today) return 'Today';
    if (txDate == yesterday) return 'Yesterday';
    if (txDate.isAfter(weekAgo)) return 'This Week';
    return 'Earlier';
  }
}

/// Modelo que representa una página de transacciones con cursor para paginación.
class TransactionPage {
  final List<Map<String, dynamic>> transactions;
  final DocumentSnapshot? lastDocument;
  final bool hasMore;

  const TransactionPage({
    required this.transactions,
    required this.lastDocument,
    required this.hasMore,
  });
}
