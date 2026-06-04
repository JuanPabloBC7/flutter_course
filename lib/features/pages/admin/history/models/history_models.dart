import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_models.freezed.dart';
part 'history_models.g.dart';

/// Model for a history transaction item.
@freezed
class HistoryTransaction with _$HistoryTransaction {
  const factory HistoryTransaction({
    required String id,
    required String title,
    required String date,
    required double amount,
    required String type,
    required String category,
    required String section,
  }) = _HistoryTransaction;

  factory HistoryTransaction.fromJson(Map<String, dynamic> json) => _$HistoryTransactionFromJson(json);
}

/// Model for account summary used in history view.
@freezed
class AccountSummary with _$AccountSummary {
  const factory AccountSummary({
    required double totalBalance,
    required double percentChange,
  }) = _AccountSummary;

  factory AccountSummary.fromJson(Map<String, dynamic> json) => _$AccountSummaryFromJson(json);
}
