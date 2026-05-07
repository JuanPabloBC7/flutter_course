// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ContactModel _$ContactModelFromJson(Map<String, dynamic> json) {
  return _ContactModel.fromJson(json);
}

/// @nodoc
mixin _$ContactModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get account => throw _privateConstructorUsedError;

  /// Serializes this ContactModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContactModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactModelCopyWith<ContactModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactModelCopyWith<$Res> {
  factory $ContactModelCopyWith(
    ContactModel value,
    $Res Function(ContactModel) then,
  ) = _$ContactModelCopyWithImpl<$Res, ContactModel>;
  @useResult
  $Res call({String id, String name, String? account});
}

/// @nodoc
class _$ContactModelCopyWithImpl<$Res, $Val extends ContactModel>
    implements $ContactModelCopyWith<$Res> {
  _$ContactModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? account = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            account: freezed == account
                ? _value.account
                : account // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContactModelImplCopyWith<$Res>
    implements $ContactModelCopyWith<$Res> {
  factory _$$ContactModelImplCopyWith(
    _$ContactModelImpl value,
    $Res Function(_$ContactModelImpl) then,
  ) = __$$ContactModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String? account});
}

/// @nodoc
class __$$ContactModelImplCopyWithImpl<$Res>
    extends _$ContactModelCopyWithImpl<$Res, _$ContactModelImpl>
    implements _$$ContactModelImplCopyWith<$Res> {
  __$$ContactModelImplCopyWithImpl(
    _$ContactModelImpl _value,
    $Res Function(_$ContactModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? account = freezed,
  }) {
    return _then(
      _$ContactModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        account: freezed == account
            ? _value.account
            : account // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ContactModelImpl implements _ContactModel {
  const _$ContactModelImpl({
    required this.id,
    required this.name,
    this.account,
  });

  factory _$ContactModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContactModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? account;

  @override
  String toString() {
    return 'ContactModel(id: $id, name: $name, account: $account)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.account, account) || other.account == account));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, account);

  /// Create a copy of ContactModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactModelImplCopyWith<_$ContactModelImpl> get copyWith =>
      __$$ContactModelImplCopyWithImpl<_$ContactModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContactModelImplToJson(this);
  }
}

abstract class _ContactModel implements ContactModel {
  const factory _ContactModel({
    required final String id,
    required final String name,
    final String? account,
  }) = _$ContactModelImpl;

  factory _ContactModel.fromJson(Map<String, dynamic> json) =
      _$ContactModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get account;

  /// Create a copy of ContactModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactModelImplCopyWith<_$ContactModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecentTransferModel _$RecentTransferModelFromJson(Map<String, dynamic> json) {
  return _RecentTransferModel.fromJson(json);
}

/// @nodoc
mixin _$RecentTransferModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this RecentTransferModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecentTransferModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecentTransferModelCopyWith<RecentTransferModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentTransferModelCopyWith<$Res> {
  factory $RecentTransferModelCopyWith(
    RecentTransferModel value,
    $Res Function(RecentTransferModel) then,
  ) = _$RecentTransferModelCopyWithImpl<$Res, RecentTransferModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String date,
    double amount,
    String status,
  });
}

/// @nodoc
class _$RecentTransferModelCopyWithImpl<$Res, $Val extends RecentTransferModel>
    implements $RecentTransferModelCopyWith<$Res> {
  _$RecentTransferModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecentTransferModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? date = null,
    Object? amount = null,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecentTransferModelImplCopyWith<$Res>
    implements $RecentTransferModelCopyWith<$Res> {
  factory _$$RecentTransferModelImplCopyWith(
    _$RecentTransferModelImpl value,
    $Res Function(_$RecentTransferModelImpl) then,
  ) = __$$RecentTransferModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String date,
    double amount,
    String status,
  });
}

/// @nodoc
class __$$RecentTransferModelImplCopyWithImpl<$Res>
    extends _$RecentTransferModelCopyWithImpl<$Res, _$RecentTransferModelImpl>
    implements _$$RecentTransferModelImplCopyWith<$Res> {
  __$$RecentTransferModelImplCopyWithImpl(
    _$RecentTransferModelImpl _value,
    $Res Function(_$RecentTransferModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecentTransferModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? date = null,
    Object? amount = null,
    Object? status = null,
  }) {
    return _then(
      _$RecentTransferModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecentTransferModelImpl implements _RecentTransferModel {
  const _$RecentTransferModelImpl({
    required this.id,
    required this.name,
    required this.date,
    required this.amount,
    required this.status,
  });

  factory _$RecentTransferModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecentTransferModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String date;
  @override
  final double amount;
  @override
  final String status;

  @override
  String toString() {
    return 'RecentTransferModel(id: $id, name: $name, date: $date, amount: $amount, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecentTransferModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, date, amount, status);

  /// Create a copy of RecentTransferModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecentTransferModelImplCopyWith<_$RecentTransferModelImpl> get copyWith =>
      __$$RecentTransferModelImplCopyWithImpl<_$RecentTransferModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RecentTransferModelImplToJson(this);
  }
}

abstract class _RecentTransferModel implements RecentTransferModel {
  const factory _RecentTransferModel({
    required final String id,
    required final String name,
    required final String date,
    required final double amount,
    required final String status,
  }) = _$RecentTransferModelImpl;

  factory _RecentTransferModel.fromJson(Map<String, dynamic> json) =
      _$RecentTransferModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get date;
  @override
  double get amount;
  @override
  String get status;

  /// Create a copy of RecentTransferModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecentTransferModelImplCopyWith<_$RecentTransferModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransfersModel {
  List<ContactModel> get contacts => throw _privateConstructorUsedError;
  List<RecentTransferModel> get recentTransfers =>
      throw _privateConstructorUsedError;

  /// Create a copy of TransfersModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransfersModelCopyWith<TransfersModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransfersModelCopyWith<$Res> {
  factory $TransfersModelCopyWith(
    TransfersModel value,
    $Res Function(TransfersModel) then,
  ) = _$TransfersModelCopyWithImpl<$Res, TransfersModel>;
  @useResult
  $Res call({
    List<ContactModel> contacts,
    List<RecentTransferModel> recentTransfers,
  });
}

/// @nodoc
class _$TransfersModelCopyWithImpl<$Res, $Val extends TransfersModel>
    implements $TransfersModelCopyWith<$Res> {
  _$TransfersModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransfersModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? contacts = null, Object? recentTransfers = null}) {
    return _then(
      _value.copyWith(
            contacts: null == contacts
                ? _value.contacts
                : contacts // ignore: cast_nullable_to_non_nullable
                      as List<ContactModel>,
            recentTransfers: null == recentTransfers
                ? _value.recentTransfers
                : recentTransfers // ignore: cast_nullable_to_non_nullable
                      as List<RecentTransferModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TransfersModelImplCopyWith<$Res>
    implements $TransfersModelCopyWith<$Res> {
  factory _$$TransfersModelImplCopyWith(
    _$TransfersModelImpl value,
    $Res Function(_$TransfersModelImpl) then,
  ) = __$$TransfersModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ContactModel> contacts,
    List<RecentTransferModel> recentTransfers,
  });
}

/// @nodoc
class __$$TransfersModelImplCopyWithImpl<$Res>
    extends _$TransfersModelCopyWithImpl<$Res, _$TransfersModelImpl>
    implements _$$TransfersModelImplCopyWith<$Res> {
  __$$TransfersModelImplCopyWithImpl(
    _$TransfersModelImpl _value,
    $Res Function(_$TransfersModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransfersModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? contacts = null, Object? recentTransfers = null}) {
    return _then(
      _$TransfersModelImpl(
        contacts: null == contacts
            ? _value._contacts
            : contacts // ignore: cast_nullable_to_non_nullable
                  as List<ContactModel>,
        recentTransfers: null == recentTransfers
            ? _value._recentTransfers
            : recentTransfers // ignore: cast_nullable_to_non_nullable
                  as List<RecentTransferModel>,
      ),
    );
  }
}

/// @nodoc

class _$TransfersModelImpl implements _TransfersModel {
  const _$TransfersModelImpl({
    required final List<ContactModel> contacts,
    required final List<RecentTransferModel> recentTransfers,
  }) : _contacts = contacts,
       _recentTransfers = recentTransfers;

  final List<ContactModel> _contacts;
  @override
  List<ContactModel> get contacts {
    if (_contacts is EqualUnmodifiableListView) return _contacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contacts);
  }

  final List<RecentTransferModel> _recentTransfers;
  @override
  List<RecentTransferModel> get recentTransfers {
    if (_recentTransfers is EqualUnmodifiableListView) return _recentTransfers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentTransfers);
  }

  @override
  String toString() {
    return 'TransfersModel(contacts: $contacts, recentTransfers: $recentTransfers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransfersModelImpl &&
            const DeepCollectionEquality().equals(other._contacts, _contacts) &&
            const DeepCollectionEquality().equals(
              other._recentTransfers,
              _recentTransfers,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_contacts),
    const DeepCollectionEquality().hash(_recentTransfers),
  );

  /// Create a copy of TransfersModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransfersModelImplCopyWith<_$TransfersModelImpl> get copyWith =>
      __$$TransfersModelImplCopyWithImpl<_$TransfersModelImpl>(
        this,
        _$identity,
      );
}

abstract class _TransfersModel implements TransfersModel {
  const factory _TransfersModel({
    required final List<ContactModel> contacts,
    required final List<RecentTransferModel> recentTransfers,
  }) = _$TransfersModelImpl;

  @override
  List<ContactModel> get contacts;
  @override
  List<RecentTransferModel> get recentTransfers;

  /// Create a copy of TransfersModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransfersModelImplCopyWith<_$TransfersModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
