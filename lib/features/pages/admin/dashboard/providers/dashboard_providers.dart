import 'package:flutter_course/core/providers/service_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── Dashboard Data ───────────────────────────────────────────────────────────

class DashboardData {
  final Map<String, dynamic> user;
  final Map<String, dynamic> account;
  final List<Map<String, dynamic>> transactions;

  const DashboardData({
    required this.user,
    required this.account,
    required this.transactions,
  });
}

// ── Dashboard Provider ───────────────────────────────────────────────────────

final dashboardProvider = FutureProvider.autoDispose<DashboardData>((ref) async {
  final userService = ref.read(userServiceProvider);
  final accountService = ref.read(accountServiceProvider);
  final transactionService = ref.read(transactionServiceProvider);

  final results = await Future.wait([
    userService.fetchUser(),
    accountService.fetchAccountSummary(),
    transactionService.fetchTransactions(limit: 4),
  ]);

  return DashboardData(
    user: results[0] as Map<String, dynamic>,
    account: results[1] as Map<String, dynamic>,
    transactions: results[2] as List<Map<String, dynamic>>,
  );
});
