// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContactModelImpl _$$ContactModelImplFromJson(Map<String, dynamic> json) =>
    _$ContactModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      account: json['account'] as String?,
    );

Map<String, dynamic> _$$ContactModelImplToJson(_$ContactModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'account': instance.account,
    };

_$RecentTransferModelImpl _$$RecentTransferModelImplFromJson(
  Map<String, dynamic> json,
) => _$RecentTransferModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  date: json['date'] as String,
  amount: (json['amount'] as num).toDouble(),
  status: json['status'] as String,
);

Map<String, dynamic> _$$RecentTransferModelImplToJson(
  _$RecentTransferModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'date': instance.date,
  'amount': instance.amount,
  'status': instance.status,
};
