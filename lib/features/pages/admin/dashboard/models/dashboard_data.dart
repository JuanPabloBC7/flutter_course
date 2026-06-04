import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_data.freezed.dart';
part 'dashboard_data.g.dart';

/// Model for account statistics.
@freezed
class AccountStats with _$AccountStats {
  const factory AccountStats({
    @Default(0) double income,
    @Default(0) double expenses,
    @Default(0) double savings,
    @Default(0) int transactionCount,
  }) = _AccountStats;

  factory AccountStats.fromJson(Map<String, dynamic> json) => _$AccountStatsFromJson(json);
}

/// Model for a transaction item.
@freezed
class TransactionItem with _$TransactionItem {
  const factory TransactionItem({
    required String id,
    required String title,
    required String date,
    required double amount,
    required String type,
    required String category,
    required String section,
  }) = _TransactionItem;

  factory TransactionItem.fromJson(Map<String, dynamic> json) => _$TransactionItemFromJson(json);
}

/// Aggregated dashboard data model.
@freezed
class DashboardModel with _$DashboardModel {
  const factory DashboardModel({
    required String username,
    required double totalBalance,
    required double percentChange,
    required AccountStats stats,
    required List<TransactionItem> transactions,
  }) = _DashboardModel;

  factory DashboardModel.fromJson(Map<String, dynamic> json) => _$DashboardModelFromJson(json);
}
