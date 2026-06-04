// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HistoryTransactionImpl _$$HistoryTransactionImplFromJson(
  Map<String, dynamic> json,
) => _$HistoryTransactionImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  date: json['date'] as String,
  amount: (json['amount'] as num).toDouble(),
  type: json['type'] as String,
  category: json['category'] as String,
  section: json['section'] as String,
);

Map<String, dynamic> _$$HistoryTransactionImplToJson(
  _$HistoryTransactionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'date': instance.date,
  'amount': instance.amount,
  'type': instance.type,
  'category': instance.category,
  'section': instance.section,
};

_$AccountSummaryImpl _$$AccountSummaryImplFromJson(Map<String, dynamic> json) =>
    _$AccountSummaryImpl(
      totalBalance: (json['totalBalance'] as num).toDouble(),
      percentChange: (json['percentChange'] as num).toDouble(),
    );

Map<String, dynamic> _$$AccountSummaryImplToJson(
  _$AccountSummaryImpl instance,
) => <String, dynamic>{
  'totalBalance': instance.totalBalance,
  'percentChange': instance.percentChange,
};
