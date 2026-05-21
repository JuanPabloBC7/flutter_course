import 'package:flutter_course/core/providers/service_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── Filter State ─────────────────────────────────────────────────────────────

final historyFilterProvider = StateProvider<String?>((ref) => null);

// ── Transactions Provider ────────────────────────────────────────────────────

final historyTransactionsProvider =
    FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final filter = ref.watch(historyFilterProvider);
  final service = ref.read(transactionServiceProvider);
  return service.fetchTransactions(filter: filter);
});

// ── Account Summary Provider ─────────────────────────────────────────────────

final historyAccountProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final service = ref.read(accountServiceProvider);
  return service.fetchAccountSummary();
});
