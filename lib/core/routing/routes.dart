import 'package:flutter/material.dart';
import 'package:flutter_course/features/auth/login/views/login_view.dart';
import 'package:flutter_course/features/auth/forgot_password/views/forgot_password_view.dart';
import 'package:flutter_course/features/admin/dashboard/views/dashboard_view.dart';
import 'package:flutter_course/temp_view.dart';

class AppRoutes {
  // Route names as constants
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String dashboard = '/dashboard';
  static const String temporalRoute = '/temporal-route';

  // Generate routes
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardView());
      case temporalRoute:
        return MaterialPageRoute(builder: (_) => const TempViewWidget());
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
