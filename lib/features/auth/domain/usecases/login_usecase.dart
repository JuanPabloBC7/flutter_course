import 'package:flutter_course/features/auth/domain/entities/login_result.dart';
import 'package:flutter_course/features/auth/domain/repositories/auth_repository.dart';

/// Use case for authenticating a user.
///
/// Encapsulates the business logic for login:
/// - Validates input parameters
/// - Delegates to the repository for actual authentication
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  /// Executes the login operation.
  ///
  /// Throws [ArgumentError] if username or password are empty.
  /// Throws [AppException] subclasses on authentication failures.
  Future<LoginResult> execute({
    required String username,
    required String password,
  }) async {
    // Business rule: username and password must not be empty
    if (username.trim().isEmpty) {
      throw ArgumentError('Username cannot be empty');
    }
    if (password.trim().isEmpty) {
      throw ArgumentError('Password cannot be empty');
    }

    return _repository.login(
      username: username.trim(),
      password: password.trim(),
    );
  }
}
