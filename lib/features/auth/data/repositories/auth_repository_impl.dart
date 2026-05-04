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

    // 2. Map raw data to domain entities
    final token = AuthToken(
      accessToken: response['token'] as String,
      refreshToken: response['refreshToken'] as String,
    );

    final userData = response['user'] as Map<String, dynamic>;
    final user = UserEntity(
      id: userData['id'] as int,
      username: userData['username'] as String,
      email: userData['email'] as String,
      fullName: userData['fullName'] as String,
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
    return _localDataSource.hasTokens();
  }
}
