import 'package:cloud_firestore/cloud_firestore.dart';

/// Script para poblar Firestore con transacciones de prueba.
///
/// Uso: llamar [seedTransactions] una sola vez estando autenticado.
///
/// Ejemplo:
/// ```dart
/// await seedTransactions();
/// ```
Future<void> seedTransactions() async {
  final firestore = FirebaseFirestore.instance;
  final batch = firestore.batch();

  // Cuenta única registrada en Firestore
  const accountId = 'dQoefdO5RFYzk5yZdL7E';

  final transactions = [
    // Mayo 2025 — Hoy
    {'title': 'Salary Deposit', 'amount': '3500.00', 'type': 'income', 'category': 'salary', 'date': DateTime(2025, 5, 4, 9, 41)},
    {'title': 'Grocery Store', 'amount': '85.45', 'type': 'expense', 'category': 'shopping', 'date': DateTime(2025, 5, 4, 14, 15)},
    {'title': 'Freelance Payment', 'amount': '450.00', 'type': 'income', 'category': 'freelance', 'date': DateTime(2025, 5, 4, 17, 30)},
    // Ayer
    {'title': 'Netflix Subscription', 'amount': '15.99', 'type': 'expense', 'category': 'entertainment', 'date': DateTime(2025, 5, 3, 8, 0)},
    {'title': 'Transfer from Juan', 'amount': '200.00', 'type': 'income', 'category': 'transfer', 'date': DateTime(2025, 5, 3, 11, 20)},
    {'title': 'Electric Bill', 'amount': '120.50', 'type': 'expense', 'category': 'utilities', 'date': DateTime(2025, 5, 3, 15, 45)},
    // Esta semana
    {'title': 'Restaurant', 'amount': '62.00', 'type': 'expense', 'category': 'food', 'date': DateTime(2025, 5, 1, 19, 30)},
    {'title': 'Refund - Amazon', 'amount': '34.99', 'type': 'income', 'category': 'refund', 'date': DateTime(2025, 5, 1, 10, 0)},
    {'title': 'Gas Station', 'amount': '55.00', 'type': 'expense', 'category': 'transport', 'date': DateTime(2025, 5, 1, 18, 15)},
    {'title': 'Gym Membership', 'amount': '40.00', 'type': 'expense', 'category': 'health', 'date': DateTime(2025, 4, 30, 9, 0)},
    // Semana anterior
    {'title': 'Water Bill', 'amount': '35.00', 'type': 'expense', 'category': 'utilities', 'date': DateTime(2025, 4, 29, 10, 0)},
    {'title': 'Bonus Payment', 'amount': '800.00', 'type': 'income', 'category': 'salary', 'date': DateTime(2025, 4, 28, 9, 0)},
    {'title': 'Uber Ride', 'amount': '12.50', 'type': 'expense', 'category': 'transport', 'date': DateTime(2025, 4, 28, 22, 30)},
    {'title': 'Coffee Shop', 'amount': '5.75', 'type': 'expense', 'category': 'food', 'date': DateTime(2025, 4, 27, 8, 15)},
    {'title': 'Spotify', 'amount': '9.99', 'type': 'expense', 'category': 'entertainment', 'date': DateTime(2025, 4, 27, 8, 0)},
    {'title': 'Client Payment', 'amount': '1200.00', 'type': 'income', 'category': 'freelance', 'date': DateTime(2025, 4, 26, 16, 0)},
    {'title': 'Pharmacy', 'amount': '28.50', 'type': 'expense', 'category': 'health', 'date': DateTime(2025, 4, 26, 12, 30)},
    {'title': 'Phone Bill', 'amount': '45.00', 'type': 'expense', 'category': 'utilities', 'date': DateTime(2025, 4, 25, 10, 0)},
    {'title': 'Supermarket', 'amount': '132.80', 'type': 'expense', 'category': 'shopping', 'date': DateTime(2025, 4, 25, 15, 45)},
    {'title': 'Transfer to Mom', 'amount': '300.00', 'type': 'expense', 'category': 'transfer', 'date': DateTime(2025, 4, 24, 9, 30)},
    // Abril
    {'title': 'Interest Income', 'amount': '15.23', 'type': 'income', 'category': 'salary', 'date': DateTime(2025, 4, 23, 0, 1)},
    {'title': 'Movie Tickets', 'amount': '24.00', 'type': 'expense', 'category': 'entertainment', 'date': DateTime(2025, 4, 22, 20, 0)},
    {'title': 'Parking Fee', 'amount': '8.00', 'type': 'expense', 'category': 'transport', 'date': DateTime(2025, 4, 22, 14, 0)},
    {'title': 'Lunch Delivery', 'amount': '18.90', 'type': 'expense', 'category': 'food', 'date': DateTime(2025, 4, 21, 12, 30)},
    {'title': 'Freelance Project', 'amount': '650.00', 'type': 'income', 'category': 'freelance', 'date': DateTime(2025, 4, 20, 11, 0)},
    {'title': 'Internet Bill', 'amount': '60.00', 'type': 'expense', 'category': 'utilities', 'date': DateTime(2025, 4, 20, 9, 0)},
    {'title': 'Book Purchase', 'amount': '22.99', 'type': 'expense', 'category': 'shopping', 'date': DateTime(2025, 4, 19, 16, 30)},
    {'title': 'Dentist', 'amount': '150.00', 'type': 'expense', 'category': 'health', 'date': DateTime(2025, 4, 18, 10, 0)},
    {'title': 'Transfer from Carlos', 'amount': '100.00', 'type': 'income', 'category': 'transfer', 'date': DateTime(2025, 4, 17, 14, 20)},
    {'title': 'Gas Station', 'amount': '48.00', 'type': 'expense', 'category': 'transport', 'date': DateTime(2025, 4, 16, 18, 0)},
    {'title': 'Dinner Out', 'amount': '75.00', 'type': 'expense', 'category': 'food', 'date': DateTime(2025, 4, 15, 20, 30)},
    {'title': 'Salary Deposit', 'amount': '3500.00', 'type': 'income', 'category': 'salary', 'date': DateTime(2025, 4, 15, 9, 0)},
    {'title': 'YouTube Premium', 'amount': '11.99', 'type': 'expense', 'category': 'entertainment', 'date': DateTime(2025, 4, 14, 8, 0)},
    {'title': 'Clothing Store', 'amount': '89.99', 'type': 'expense', 'category': 'shopping', 'date': DateTime(2025, 4, 13, 15, 0)},
    {'title': 'Rent Payment', 'amount': '950.00', 'type': 'expense', 'category': 'utilities', 'date': DateTime(2025, 4, 12, 9, 0)},
    {'title': 'Taxi Ride', 'amount': '15.00', 'type': 'expense', 'category': 'transport', 'date': DateTime(2025, 4, 11, 22, 0)},
    {'title': 'Refund - Store', 'amount': '45.00', 'type': 'income', 'category': 'refund', 'date': DateTime(2025, 4, 10, 11, 0)},
    {'title': 'Pizza Night', 'amount': '32.00', 'type': 'expense', 'category': 'food', 'date': DateTime(2025, 4, 9, 19, 45)},
    {'title': 'Eye Doctor', 'amount': '200.00', 'type': 'expense', 'category': 'health', 'date': DateTime(2025, 4, 8, 10, 30)},
    {'title': 'Freelance Bonus', 'amount': '300.00', 'type': 'income', 'category': 'freelance', 'date': DateTime(2025, 4, 7, 15, 0)},
    {'title': 'Streaming Bundle', 'amount': '25.99', 'type': 'expense', 'category': 'entertainment', 'date': DateTime(2025, 4, 6, 8, 0)},
    {'title': 'Transfer to Savings', 'amount': '500.00', 'type': 'expense', 'category': 'transfer', 'date': DateTime(2025, 4, 5, 9, 0)},
    {'title': 'Grocery Run', 'amount': '67.30', 'type': 'expense', 'category': 'shopping', 'date': DateTime(2025, 4, 4, 17, 0)},
    {'title': 'Bus Pass', 'amount': '30.00', 'type': 'expense', 'category': 'transport', 'date': DateTime(2025, 4, 3, 7, 30)},
    {'title': 'Insurance Payment', 'amount': '180.00', 'type': 'expense', 'category': 'utilities', 'date': DateTime(2025, 4, 2, 10, 0)},
    {'title': 'Birthday Gift Received', 'amount': '50.00', 'type': 'income', 'category': 'transfer', 'date': DateTime(2025, 4, 1, 12, 0)},
    {'title': 'Breakfast Cafe', 'amount': '14.50', 'type': 'expense', 'category': 'food', 'date': DateTime(2025, 3, 31, 8, 30)},
    {'title': 'Vitamin Supplements', 'amount': '35.00', 'type': 'expense', 'category': 'health', 'date': DateTime(2025, 3, 30, 11, 0)},
    {'title': 'Side Project Income', 'amount': '250.00', 'type': 'income', 'category': 'freelance', 'date': DateTime(2025, 3, 29, 18, 0)},
    {'title': 'Concert Tickets', 'amount': '85.00', 'type': 'expense', 'category': 'entertainment', 'date': DateTime(2025, 3, 28, 20, 0)},
  ];

  for (final tx in transactions) {
    final docRef = firestore.collection('transactions').doc();
    batch.set(docRef, {
      'accountId': accountId,
      'amount': tx['amount'],
      'type': tx['type'],
      'category': tx['category'],
      'title': tx['title'],
      'date': Timestamp.fromDate(tx['date'] as DateTime),
    });
  }

  // Ejecutar todas las escrituras en una sola operación atómica
  await batch.commit();
}
