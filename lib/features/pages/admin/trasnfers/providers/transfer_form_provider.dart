import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider que obtiene las cuentas del usuario desde Firestore.
final accountsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('accounts')
      .get();

  return snapshot.docs.map((doc) {
    final data = doc.data();
    return {
      'id': doc.id,
      'name': data['name'] as String? ?? '',
      'type': data['type'] as String? ?? '',
      'balance': data['balance'],
      'currency': data['currency'] as String? ?? 'GTQ',
    };
  }).toList();
});

/// Categorías disponibles para transferencias.
const transferCategories = [
  'salary',
  'shopping',
  'entertainment',
  'transfer',
  'utilities',
  'food',
  'transport',
  'health',
  'freelance',
  'refund',
];
