import 'package:flutter_course/core/network/app_exceptions.dart';
import 'package:flutter_course/features/auth/auth_injection.dart';
import 'package:flutter_course/features/auth/domain/entities/login_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── Auth State ───────────────────────────────────────────────────────────────

enum AuthStatus { idle, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final LoginResult? loginResult;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.idle,
    this.loginResult,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    LoginResult? loginResult,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      loginResult: loginResult ?? this.loginResult,
      errorMessage: errorMessage,
    );
  }

  bool get isLoading => status == AuthStatus.loading;
  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get hasError => status == AuthStatus.error;
}

// ── Auth Notifier ────────────────────────────────────────────────────────────

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  Future<void> login({required String username, required String password}) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);

    try {
      final result = await AuthInjection.loginUseCase.execute(
        username: username,
        password: password,
      );
      state = AuthState(status: AuthStatus.authenticated, loginResult: result);
    } on AppException catch (e) {
      state = AuthState(status: AuthStatus.error, errorMessage: e.message);
    } on ArgumentError catch (e) {
      state = AuthState(status: AuthStatus.error, errorMessage: e.message);
    } catch (_) {
      state = const AuthState(
        status: AuthStatus.error,
        errorMessage: 'An unexpected error occurred.',
      );
    }
  }

  Future<void> logout() async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await AuthInjection.logoutUseCase.execute();
    } catch (_) {
      // Continue with logout even if API fails
    }
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  Future<void> checkSession() async {
    final isAuth = await AuthInjection.checkSessionUseCase.execute();
    state = AuthState(
      status: isAuth ? AuthStatus.authenticated : AuthStatus.unauthenticated,
    );
  }

  void clearError() {
    if (state.hasError) {
      state = state.copyWith(status: AuthStatus.idle, errorMessage: null);
    }
  }
}

// ── Provider ─────────────────────────────────────────────────────────────────

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
