import 'package:flutter_course/features/auth/domain/repositories/auth_repository.dart';

/// Use case for logging out the current user.
///
/// Encapsulates the business logic for logout:
/// - Clears stored session/tokens
/// - Notifies the backend
class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  /// Executes the logout operation.
  Future<void> execute() async {
    return _repository.logout();
  }
}
