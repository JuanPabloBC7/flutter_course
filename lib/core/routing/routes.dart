import 'package:flutter/material.dart';
import 'package:flutter_course/core/routing/auth_guard.dart';
import 'package:flutter_course/features/layouts/admin_layout_view.dart';
import 'package:flutter_course/features/pages/auth/forgot_password/forgot_password_view.dart';
import 'package:flutter_course/features/pages/auth/login/login_view.dart';
import 'package:flutter_course/features/pages/splash/splash_view.dart';

class AppRoutes {
  // ── Route names ────────────────────────────────────────────────────────────

  // Public routes (no auth required)
  static const String splash = '/';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';

  // Protected routes (auth required)
  static const String dashboard = '/dashboard';

  // ── Public routes list (used by guard to skip protection) ──────────────────

  static const List<String> publicRoutes = [
    splash,
    login,
    forgotPassword,
  ];

  /// Returns true if the given route requires authentication.
  static bool isProtectedRoute(String? routeName) {
    if (routeName == null) return true;
    return !publicRoutes.contains(routeName);
  }

  // ── Route generation ───────────────────────────────────────────────────────

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Public routes
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());

      // Protected routes (wrapped with AuthGuard)
      case dashboard:
        return MaterialPageRoute(
          builder: (_) => const AuthGuard(
            child: AdminLayoutView(),
          ),
        );

      // Fallback
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
