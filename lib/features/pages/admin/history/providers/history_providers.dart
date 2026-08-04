import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_course/core/providers/service_providers.dart';
import 'package:flutter_course/features/pages/admin/history/services/transaction_firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── Service Provider ─────────────────────────────────────────────────────────

final transactionFirestoreServiceProvider =
    Provider<TransactionFirestoreService>((ref) => TransactionFirestoreService());

// ── Filter State ─────────────────────────────────────────────────────────────

final historyFilterProvider = StateProvider<String?>((ref) => null);

// ── Paginated Transactions State ─────────────────────────────────────────────

/// Estado que mantiene las transacciones acumuladas y el cursor de paginación.
class HistoryState {
  final List<Map<String, dynamic>> transactions;
  final DocumentSnapshot? lastDocument;
  final bool hasMore;
  final bool isLoadingMore;
  final String? error;

  const HistoryState({
    this.transactions = const [],
    this.lastDocument,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.error,
  });

  HistoryState copyWith({
    List<Map<String, dynamic>>? transactions,
    DocumentSnapshot? lastDocument,
    bool? hasMore,
    bool? isLoadingMore,
    String? error,
  }) {
    return HistoryState(
      transactions: transactions ?? this.transactions,
      lastDocument: lastDocument ?? this.lastDocument,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
    );
  }
}

// ── History Notifier ─────────────────────────────────────────────────────────

class HistoryNotifier extends StateNotifier<AsyncValue<HistoryState>> {
  final TransactionFirestoreService _service;
  final Ref _ref;

  HistoryNotifier(this._service, this._ref) : super(const AsyncValue.loading()) {
    loadFirstPage();
  }

  /// Carga la primera página de transacciones.
  Future<void> loadFirstPage() async {
    state = const AsyncValue.loading();

    try {
      final filter = _ref.read(historyFilterProvider);
      final page = await _service.fetchFirstPage(filter: filter);

      state = AsyncValue.data(HistoryState(
        transactions: page.transactions,
        lastDocument: page.lastDocument,
        hasMore: page.hasMore,
      ));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Carga la siguiente página de transacciones (paginación).
  Future<void> loadNextPage() async {
    final currentState = state.valueOrNull;
    if (currentState == null || !currentState.hasMore || currentState.isLoadingMore) {
      return;
    }

    if (currentState.lastDocument == null) return;

    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));

    try {
      final filter = _ref.read(historyFilterProvider);
      final page = await _service.fetchNextPage(
        lastDocument: currentState.lastDocument!,
        filter: filter,
      );

      state = AsyncValue.data(HistoryState(
        transactions: [...currentState.transactions, ...page.transactions],
        lastDocument: page.lastDocument ?? currentState.lastDocument,
        hasMore: page.hasMore,
      ));
    } catch (e) {
      state = AsyncValue.data(
        currentState.copyWith(isLoadingMore: false, error: e.toString()),
      );
    }
  }

  /// Recarga desde cero (pull-to-refresh).
  Future<void> refresh() async {
    await loadFirstPage();
  }
}

// ── Providers ────────────────────────────────────────────────────────────────

final historyTransactionsProvider =
    StateNotifierProvider.autoDispose<HistoryNotifier, AsyncValue<HistoryState>>(
        (ref) {
  final service = ref.read(transactionFirestoreServiceProvider);
  final notifier = HistoryNotifier(service, ref);

  // Recargar cuando cambia el filtro
  ref.listen(historyFilterProvider, (previous, next) {
    notifier.loadFirstPage();
  });

  return notifier;
});

// ── Account Summary Provider ─────────────────────────────────────────────────

final historyAccountProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final service = ref.read(accountServiceProvider);
  return service.fetchAccountSummary();
});
