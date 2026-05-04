import 'package:flutter_course/features/auth/domain/repositories/auth_repository.dart';

/// Use case for checking if the user has an active session.
///
/// Used on app startup and by the route guard to determine
/// whether to show the login screen or the main app.
class CheckSessionUseCase {
  final AuthRepository _repository;

  CheckSessionUseCase(this._repository);

  /// Returns `true` if the user has a valid stored session.
  Future<bool> execute() async {
    return _repository.isAuthenticated();
  }
}
