import 'package:flutter_course/features/auth/domain/entities/auth_token.dart';
import 'package:flutter_course/features/auth/domain/entities/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_result.freezed.dart';
part 'login_result.g.dart';

/// The result of a successful login operation.
@freezed
class LoginResult with _$LoginResult {
  const factory LoginResult({
    required UserEntity user,
    required AuthToken token,
  }) = _LoginResult;

  factory LoginResult.fromJson(Map<String, dynamic> json) => _$LoginResultFromJson(json);
}
