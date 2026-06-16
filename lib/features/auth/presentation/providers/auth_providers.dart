import 'package:flutter_course/core/config/feature_flags.dart';
import 'package:flutter_course/core/network/app_exceptions.dart';
import 'package:flutter_course/features/auth/auth_injection.dart';
import 'package:flutter_course/features/auth/data/datasources/auth_firebase_datasource.dart';
import 'package:flutter_course/features/auth/domain/entities/auth_token.dart';
import 'package:flutter_course/features/auth/domain/entities/login_result.dart';
import 'package:flutter_course/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_course/features/auth/presentation/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:flutter_course/features/auth/presentation/state/auth_state.dart';

// ── Auth Notifier ────────────────────────────────────────────────────────────

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthFirebaseDatasource _firebaseDatasource = AuthFirebaseDatasource();

  AuthNotifier() : super(const AuthState.idle());

  Future<void> login({required String username, required String password}) async {
    state = const AuthState.loading();

    try {
      LoginResult result;

      if (FeatureFlags.useFirebaseAuth) {
        // Firebase Auth: email/password
        final response = await _firebaseDatasource.login(
          email: username,
          password: password,
        );

        await AuthInjection.localDataSource.saveTokens(
          accessToken: response['accessToken'] as String? ?? '',
          refreshToken: response['refreshToken'] as String? ?? '',
        );

        result = LoginResult(
          user: UserEntity(
            id: response['id'].hashCode,
            username: response['username'] as String? ?? '',
            email: response['email'] as String? ?? '',
            fullName: '${response['firstName'] ?? ''} ${response['lastName'] ?? ''}'.trim(),
          ),
          token: AuthToken(
            accessToken: response['accessToken'] as String? ?? '',
            refreshToken: response['refreshToken'] as String? ?? '',
          ),
        );
      } else if (FeatureFlags.useDummyJsonApi) {
        // DummyJSON API
        result = await AuthInjection.loginUseCase.execute(
          username: username,
          password: password,
        );
      } else {
        // Local mock
        await Future.delayed(const Duration(milliseconds: 500));

        await AuthInjection.localDataSource.saveTokens(
          accessToken: 'mock-jwt-access-token',
          refreshToken: 'mock-jwt-refresh-token',
        );

        result = const LoginResult(
          user: UserEntity(
            id: 1,
            username: 'emilys',
            email: 'emily.johnson@x.dummyjson.com',
            fullName: 'Emily Johnson',
          ),
          token: AuthToken(
            accessToken: 'mock-jwt-access-token',
            refreshToken: 'mock-jwt-refresh-token',
          ),
        );
      }

      state = AuthState.authenticated(loginResult: result);
    } on AppException catch (e) {
      state = AuthState.error(message: e.message);
    } on ArgumentError catch (e) {
      state = AuthState.error(message: e.message ?? 'Validation error');
    } catch (e) {
      state = AuthState.error(message: 'An unexpected error occurred: $e');
    }
  }

  Future<void> logout() async {
    state = const AuthState.loading();
    try {
      if (FeatureFlags.useFirebaseAuth) {
        await _firebaseDatasource.logout();
      }
      await AuthInjection.logoutUseCase.execute();
    } catch (_) {
      // Continue with logout even if API fails
    }
    state = const AuthState.unauthenticated();
  }

  Future<void> checkSession() async {
    if (FeatureFlags.useFirebaseAuth) {
      final isAuth = await _firebaseDatasource.isAuthenticated();
      state = isAuth ? const AuthState.authenticated(loginResult: null) : const AuthState.unauthenticated();
    } else {
      final isAuth = await AuthInjection.checkSessionUseCase.execute();
      state = isAuth ? const AuthState.authenticated(loginResult: null) : const AuthState.unauthenticated();
    }
  }

  void clearError() {
    if (state is AuthError) {
      state = const AuthState.idle();
    }
  }
}

// ── Provider ─────────────────────────────────────────────────────────────────

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
