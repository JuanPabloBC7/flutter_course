import 'package:flutter_course/core/config/feature_flags.dart';
import 'package:flutter_course/core/network/app_exceptions.dart';
import 'package:flutter_course/features/auth/auth_injection.dart';
import 'package:flutter_course/features/auth/domain/entities/auth_token.dart';
import 'package:flutter_course/features/auth/domain/entities/login_result.dart';
import 'package:flutter_course/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_course/features/auth/presentation/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:flutter_course/features/auth/presentation/state/auth_state.dart';

// ── Auth Notifier ────────────────────────────────────────────────────────────

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState.idle());

  Future<void> login({required String username, required String password}) async {
    state = const AuthState.loading();

    try {
      LoginResult result;

      if (FeatureFlags.useDummyJsonApi) {
        // Real API: dummyJSON
        result = await AuthInjection.loginUseCase.execute(
          username: username,
          password: password,
        );
      } else {
        // Local mock: no API call needed
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
    } catch (_) {
      state = const AuthState.error(message: 'An unexpected error occurred.');
    }
  }

  Future<void> logout() async {
    state = const AuthState.loading();
    try {
      await AuthInjection.logoutUseCase.execute();
    } catch (_) {
      // Continue with logout even if API fails
    }
    state = const AuthState.unauthenticated();
  }

  Future<void> checkSession() async {
    final isAuth = await AuthInjection.checkSessionUseCase.execute();
    state = isAuth ? const AuthState.authenticated(loginResult: null) : const AuthState.unauthenticated();
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
