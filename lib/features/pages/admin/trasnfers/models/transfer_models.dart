import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer_models.freezed.dart';
part 'transfer_models.g.dart';

/// Model for a frequent contact.
@freezed
class ContactModel with _$ContactModel {
  const factory ContactModel({
    required String id,
    required String name,
    String? account,
  }) = _ContactModel;

  factory ContactModel.fromJson(Map<String, dynamic> json) => _$ContactModelFromJson(json);
}

/// Model for a recent transfer.
@freezed
class RecentTransferModel with _$RecentTransferModel {
  const factory RecentTransferModel({
    required String id,
    required String name,
    required String date,
    required double amount,
    required String status,
  }) = _RecentTransferModel;

  factory RecentTransferModel.fromJson(Map<String, dynamic> json) => _$RecentTransferModelFromJson(json);
}

/// Aggregated transfers data model.
@freezed
class TransfersModel with _$TransfersModel {
  const factory TransfersModel({
    required List<ContactModel> contacts,
    required List<RecentTransferModel> recentTransfers,
  }) = _TransfersModel;
}
