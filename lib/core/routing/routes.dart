import 'package:flutter/material.dart';
import 'package:flutter_course/features/layouts/admin_layout_view.dart';
import 'package:flutter_course/features/pages/auth/forgot_password/forgot_password_view.dart';
import 'package:flutter_course/features/pages/auth/login/login_view.dart';

class AppRoutes {
  // Route names as constants
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String dashboard = '/dashboard';

  // Generate routes
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const AdminLayoutView());
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
