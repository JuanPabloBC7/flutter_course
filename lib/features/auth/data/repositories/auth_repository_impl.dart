import 'package:flutter_course/core/config/feature_flags.dart';
import 'package:flutter_course/core/network/app_exceptions.dart';
import 'package:flutter_course/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:flutter_course/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_course/features/auth/domain/entities/auth_token.dart';
import 'package:flutter_course/features/auth/domain/entities/login_result.dart';
import 'package:flutter_course/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_course/features/auth/domain/repositories/auth_repository.dart';

/// Concrete implementation of [AuthRepository].
///
/// Coordinates between remote and local data sources:
/// - Remote: API calls for login/logout/reset
/// - Local: Token persistence for session management
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<LoginResult> login({
    required String username,
    required String password,
  }) async {
    // 1. Call remote API
    final response = await _remoteDataSource.login(
      username: username,
      password: password,
    );

    // 2. Map dummyJSON response to domain entities
    // dummyJSON returns user data at the top level alongside tokens
    final token = AuthToken(
      accessToken: response['accessToken'] as String? ?? response['token'] as String? ?? '',
      refreshToken: response['refreshToken'] as String? ?? '',
    );

    final user = UserEntity(
      id: response['id'] as int? ?? 0,
      username: response['username'] as String? ?? '',
      email: response['email'] as String? ?? '',
      fullName: '${response['firstName'] ?? ''} ${response['lastName'] ?? ''}'.trim(),
    );

    // 3. Persist tokens locally
    await _localDataSource.saveTokens(
      accessToken: token.accessToken,
      refreshToken: token.refreshToken,
    );

    return LoginResult(user: user, token: token);
  }

  @override
  Future<void> logout() async {
    // 1. Notify backend (best effort)
    try {
      await _remoteDataSource.logout();
    } catch (_) {
      // Continue with local cleanup even if remote fails
    }

    // 2. Clear local tokens
    await _localDataSource.clearTokens();
  }

  @override
  Future<void> requestPasswordReset({
    required String username,
    required String email,
  }) async {
    await _remoteDataSource.requestPasswordReset(
      username: username,
      email: email,
    );
  }

  @override
  Future<bool> isAuthenticated() async {
    final hasTokens = await _localDataSource.hasTokens();
    if (!hasTokens) return false;

    if (FeatureFlags.useDummyJsonApi) {
      // Validate the token by calling auth/me
      try {
        final token = await _localDataSource.getAccessToken();
        if (token == null) return false;
        await _remoteDataSource.getCurrentUser(token: token);
        return true;
      } catch (_) {
        try {
          await refreshSession();
          return true;
        } catch (_) {
          await _localDataSource.clearTokens();
          return false;
        }
      }
    } else {
      // Temporary: trust local tokens without API validation
      return true;
    }
  }

  @override
  Future<UserEntity> getCurrentUser() async {
    final token = await _localDataSource.getAccessToken();
    if (token == null || token.isEmpty) {
      throw const UnauthorizedException(message: 'No access token found.');
    }

    final response = await _remoteDataSource.getCurrentUser(token: token);

    return UserEntity(
      id: response['id'] as int? ?? 0,
      username: response['username'] as String? ?? '',
      email: response['email'] as String? ?? '',
      fullName: '${response['firstName'] ?? ''} ${response['lastName'] ?? ''}'.trim(),
    );
  }

  @override
  Future<void> refreshSession() async {
    final refreshToken = await _localDataSource.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      throw const UnauthorizedException(message: 'No refresh token found.');
    }

    final response = await _remoteDataSource.refreshToken(refreshToken: refreshToken);

    // Persist new tokens
    await _localDataSource.saveTokens(
      accessToken: response['accessToken'] as String? ?? response['token'] as String? ?? '',
      refreshToken: response['refreshToken'] as String? ?? refreshToken,
    );
  }
}
