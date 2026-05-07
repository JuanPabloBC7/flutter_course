// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HistoryTransaction _$HistoryTransactionFromJson(Map<String, dynamic> json) {
  return _HistoryTransaction.fromJson(json);
}

/// @nodoc
mixin _$HistoryTransaction {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get section => throw _privateConstructorUsedError;

  /// Serializes this HistoryTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HistoryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HistoryTransactionCopyWith<HistoryTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryTransactionCopyWith<$Res> {
  factory $HistoryTransactionCopyWith(
    HistoryTransaction value,
    $Res Function(HistoryTransaction) then,
  ) = _$HistoryTransactionCopyWithImpl<$Res, HistoryTransaction>;
  @useResult
  $Res call({
    String id,
    String title,
    String date,
    double amount,
    String type,
    String category,
    String section,
  });
}

/// @nodoc
class _$HistoryTransactionCopyWithImpl<$Res, $Val extends HistoryTransaction>
    implements $HistoryTransactionCopyWith<$Res> {
  _$HistoryTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistoryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? date = null,
    Object? amount = null,
    Object? type = null,
    Object? category = null,
    Object? section = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            section: null == section
                ? _value.section
                : section // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HistoryTransactionImplCopyWith<$Res>
    implements $HistoryTransactionCopyWith<$Res> {
  factory _$$HistoryTransactionImplCopyWith(
    _$HistoryTransactionImpl value,
    $Res Function(_$HistoryTransactionImpl) then,
  ) = __$$HistoryTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String date,
    double amount,
    String type,
    String category,
    String section,
  });
}

/// @nodoc
class __$$HistoryTransactionImplCopyWithImpl<$Res>
    extends _$HistoryTransactionCopyWithImpl<$Res, _$HistoryTransactionImpl>
    implements _$$HistoryTransactionImplCopyWith<$Res> {
  __$$HistoryTransactionImplCopyWithImpl(
    _$HistoryTransactionImpl _value,
    $Res Function(_$HistoryTransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HistoryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? date = null,
    Object? amount = null,
    Object? type = null,
    Object? category = null,
    Object? section = null,
  }) {
    return _then(
      _$HistoryTransactionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        section: null == section
            ? _value.section
            : section // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HistoryTransactionImpl implements _HistoryTransaction {
  const _$HistoryTransactionImpl({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
    required this.category,
    required this.section,
  });

  factory _$HistoryTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryTransactionImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String date;
  @override
  final double amount;
  @override
  final String type;
  @override
  final String category;
  @override
  final String section;

  @override
  String toString() {
    return 'HistoryTransaction(id: $id, title: $title, date: $date, amount: $amount, type: $type, category: $category, section: $section)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.section, section) || other.section == section));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    date,
    amount,
    type,
    category,
    section,
  );

  /// Create a copy of HistoryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryTransactionImplCopyWith<_$HistoryTransactionImpl> get copyWith =>
      __$$HistoryTransactionImplCopyWithImpl<_$HistoryTransactionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryTransactionImplToJson(this);
  }
}

abstract class _HistoryTransaction implements HistoryTransaction {
  const factory _HistoryTransaction({
    required final String id,
    required final String title,
    required final String date,
    required final double amount,
    required final String type,
    required final String category,
    required final String section,
  }) = _$HistoryTransactionImpl;

  factory _HistoryTransaction.fromJson(Map<String, dynamic> json) =
      _$HistoryTransactionImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get date;
  @override
  double get amount;
  @override
  String get type;
  @override
  String get category;
  @override
  String get section;

  /// Create a copy of HistoryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistoryTransactionImplCopyWith<_$HistoryTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AccountSummary _$AccountSummaryFromJson(Map<String, dynamic> json) {
  return _AccountSummary.fromJson(json);
}

/// @nodoc
mixin _$AccountSummary {
  double get totalBalance => throw _privateConstructorUsedError;
  double get percentChange => throw _privateConstructorUsedError;

  /// Serializes this AccountSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AccountSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountSummaryCopyWith<AccountSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountSummaryCopyWith<$Res> {
  factory $AccountSummaryCopyWith(
    AccountSummary value,
    $Res Function(AccountSummary) then,
  ) = _$AccountSummaryCopyWithImpl<$Res, AccountSummary>;
  @useResult
  $Res call({double totalBalance, double percentChange});
}

/// @nodoc
class _$AccountSummaryCopyWithImpl<$Res, $Val extends AccountSummary>
    implements $AccountSummaryCopyWith<$Res> {
  _$AccountSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? totalBalance = null, Object? percentChange = null}) {
    return _then(
      _value.copyWith(
            totalBalance: null == totalBalance
                ? _value.totalBalance
                : totalBalance // ignore: cast_nullable_to_non_nullable
                      as double,
            percentChange: null == percentChange
                ? _value.percentChange
                : percentChange // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AccountSummaryImplCopyWith<$Res>
    implements $AccountSummaryCopyWith<$Res> {
  factory _$$AccountSummaryImplCopyWith(
    _$AccountSummaryImpl value,
    $Res Function(_$AccountSummaryImpl) then,
  ) = __$$AccountSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double totalBalance, double percentChange});
}

/// @nodoc
class __$$AccountSummaryImplCopyWithImpl<$Res>
    extends _$AccountSummaryCopyWithImpl<$Res, _$AccountSummaryImpl>
    implements _$$AccountSummaryImplCopyWith<$Res> {
  __$$AccountSummaryImplCopyWithImpl(
    _$AccountSummaryImpl _value,
    $Res Function(_$AccountSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? totalBalance = null, Object? percentChange = null}) {
    return _then(
      _$AccountSummaryImpl(
        totalBalance: null == totalBalance
            ? _value.totalBalance
            : totalBalance // ignore: cast_nullable_to_non_nullable
                  as double,
        percentChange: null == percentChange
            ? _value.percentChange
            : percentChange // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountSummaryImpl implements _AccountSummary {
  const _$AccountSummaryImpl({
    required this.totalBalance,
    required this.percentChange,
  });

  factory _$AccountSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountSummaryImplFromJson(json);

  @override
  final double totalBalance;
  @override
  final double percentChange;

  @override
  String toString() {
    return 'AccountSummary(totalBalance: $totalBalance, percentChange: $percentChange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountSummaryImpl &&
            (identical(other.totalBalance, totalBalance) ||
                other.totalBalance == totalBalance) &&
            (identical(other.percentChange, percentChange) ||
                other.percentChange == percentChange));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalBalance, percentChange);

  /// Create a copy of AccountSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountSummaryImplCopyWith<_$AccountSummaryImpl> get copyWith =>
      __$$AccountSummaryImplCopyWithImpl<_$AccountSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountSummaryImplToJson(this);
  }
}

abstract class _AccountSummary implements AccountSummary {
  const factory _AccountSummary({
    required final double totalBalance,
    required final double percentChange,
  }) = _$AccountSummaryImpl;

  factory _AccountSummary.fromJson(Map<String, dynamic> json) =
      _$AccountSummaryImpl.fromJson;

  @override
  double get totalBalance;
  @override
  double get percentChange;

  /// Create a copy of AccountSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountSummaryImplCopyWith<_$AccountSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
