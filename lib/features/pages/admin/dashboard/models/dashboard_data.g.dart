// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountStatsImpl _$$AccountStatsImplFromJson(Map<String, dynamic> json) =>
    _$AccountStatsImpl(
      income: (json['income'] as num?)?.toDouble() ?? 0,
      expenses: (json['expenses'] as num?)?.toDouble() ?? 0,
      savings: (json['savings'] as num?)?.toDouble() ?? 0,
      transactionCount: (json['transactionCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$AccountStatsImplToJson(_$AccountStatsImpl instance) =>
    <String, dynamic>{
      'income': instance.income,
      'expenses': instance.expenses,
      'savings': instance.savings,
      'transactionCount': instance.transactionCount,
    };

_$TransactionItemImpl _$$TransactionItemImplFromJson(
  Map<String, dynamic> json,
) => _$TransactionItemImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  date: json['date'] as String,
  amount: (json['amount'] as num).toDouble(),
  type: json['type'] as String,
  category: json['category'] as String,
  section: json['section'] as String,
);

Map<String, dynamic> _$$TransactionItemImplToJson(
  _$TransactionItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'date': instance.date,
  'amount': instance.amount,
  'type': instance.type,
  'category': instance.category,
  'section': instance.section,
};

_$DashboardModelImpl _$$DashboardModelImplFromJson(Map<String, dynamic> json) =>
    _$DashboardModelImpl(
      username: json['username'] as String,
      totalBalance: (json['totalBalance'] as num).toDouble(),
      percentChange: (json['percentChange'] as num).toDouble(),
      stats: AccountStats.fromJson(json['stats'] as Map<String, dynamic>),
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => TransactionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DashboardModelImplToJson(
  _$DashboardModelImpl instance,
) => <String, dynamic>{
  'username': instance.username,
  'totalBalance': instance.totalBalance,
  'percentChange': instance.percentChange,
  'stats': instance.stats,
  'transactions': instance.transactions,
};
