import 'package:flutter_course/core/providers/service_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── Transfers Data ───────────────────────────────────────────────────────────

class TransfersData {
  final List<Map<String, dynamic>> contacts;
  final List<Map<String, dynamic>> recentTransfers;

  const TransfersData({
    required this.contacts,
    required this.recentTransfers,
  });
}

// ── Transfers Provider ───────────────────────────────────────────────────────

final transfersProvider = FutureProvider.autoDispose<TransfersData>((ref) async {
  final service = ref.read(transferServiceProvider);

  final results = await Future.wait([
    service.fetchFrequentContacts(),
    service.fetchRecentTransfers(),
  ]);

  return TransfersData(
    contacts: results[0],
    recentTransfers: results[1],
  );
});
