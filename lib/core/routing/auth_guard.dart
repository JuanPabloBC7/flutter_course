import 'package:flutter/material.dart';
import 'package:flutter_course/core/routing/routes.dart';
import 'package:flutter_course/features/auth/auth_injection.dart';
import 'package:flutter_course/features/auth/domain/usecases/check_session_usecase.dart';

/// Route guard that protects private routes from unauthenticated access.
///
/// Wraps protected routes and checks for a valid session before rendering.
/// If no session exists, redirects to the login screen.
class AuthGuard extends StatefulWidget {
  final Widget child;

  const AuthGuard({super.key, required this.child});

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  final CheckSessionUseCase _checkSession = AuthInjection.checkSessionUseCase;
  late Future<bool> _authCheck;

  @override
  void initState() {
    super.initState();
    _authCheck = _checkSession.execute();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _authCheck,
      builder: (context, snapshot) {
        // While checking session, show a loading indicator
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final isAuthenticated = snapshot.data ?? false;

        if (!isAuthenticated) {
          // Redirect to login on next frame to avoid build-phase navigation
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            }
          });

          // Show empty scaffold while redirecting
          return const Scaffold(body: SizedBox.shrink());
        }

        // User is authenticated, render the protected content
        return widget.child;
      },
    );
  }
}
