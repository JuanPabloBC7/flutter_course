import 'package:flutter_course/features/auth/domain/entities/auth_token.dart';
import 'package:flutter_course/features/auth/domain/entities/user_entity.dart';

/// The result of a successful login operation.
class LoginResult {
  final UserEntity user;
  final AuthToken token;

  const LoginResult({
    required this.user,
    required this.token,
  });
}
