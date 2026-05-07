import 'package:flutter_course/features/auth/domain/entities/login_result.dart';
import 'package:flutter_course/features/auth/domain/entities/user_entity.dart';

/// Abstract contract for authentication operations.
/// The Data layer provides the concrete implementation.
abstract class AuthRepository {
  /// Authenticates a user with [username] and [password].
  /// Returns a [LoginResult] on success, throws [AppException] on failure.
  Future<LoginResult> login({
    required String username,
    required String password,
  });

  /// Logs out the current user and clears stored credentials.
  Future<void> logout();

  /// Requests a password reset email for the given [username] and [email].
  Future<void> requestPasswordReset({
    required String username,
    required String email,
  });

  /// Checks if the user has a valid stored session by calling auth/me.
  /// Returns true if the token is still valid.
  Future<bool> isAuthenticated();

  /// Gets the current user profile using the stored token.
  /// Calls auth/me to validate and retrieve user data.
  Future<UserEntity> getCurrentUser();

  /// Refreshes the access token using the stored refresh token.
  /// Persists the new tokens locally.
  Future<void> refreshSession();
}
