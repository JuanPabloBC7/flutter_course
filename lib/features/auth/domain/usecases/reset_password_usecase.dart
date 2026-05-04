import 'package:flutter_course/features/auth/domain/repositories/auth_repository.dart';

/// Use case for requesting a password reset.
///
/// Encapsulates the business logic for password reset:
/// - Validates input parameters
/// - Delegates to the repository
class ResetPasswordUseCase {
  final AuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  /// Executes the password reset request.
  ///
  /// Throws [ArgumentError] if username or email are empty.
  /// Throws [AppException] subclasses on failures.
  Future<void> execute({
    required String username,
    required String email,
  }) async {
    if (username.trim().isEmpty) {
      throw ArgumentError('Username cannot be empty');
    }
    if (email.trim().isEmpty) {
      throw ArgumentError('Email cannot be empty');
    }

    return _repository.requestPasswordReset(
      username: username.trim(),
      email: email.trim(),
    );
  }
}
