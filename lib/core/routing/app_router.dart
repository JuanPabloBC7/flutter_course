import 'package:flutter/material.dart';
import 'package:flutter_course/core/config/feature_flags.dart';
import 'package:flutter_course/core/widgets/product_card.dart';
import 'package:flutter_course/features/auth/auth_injection.dart';
import 'package:flutter_course/features/auth/data/datasources/auth_firebase_datasource.dart';
import 'package:flutter_course/features/layouts/admin_layout_view.dart';
import 'package:flutter_course/features/pages/admin/configuration/configuration_view.dart';
import 'package:flutter_course/features/pages/admin/ecommerce/ecommerce_view.dart';
import 'package:flutter_course/features/pages/admin/product_detail/product_detail_view.dart';
import 'package:flutter_course/features/pages/admin/profile/profile_view.dart';
import 'package:flutter_course/features/pages/auth/forgot_password/forgot_password_view.dart';
import 'package:flutter_course/features/pages/auth/login/login_view.dart';
import 'package:flutter_course/features/pages/core/onboarding/onboarding_view.dart';
import 'package:flutter_course/features/pages/core/splash/splash_view.dart';
import 'package:go_router/go_router.dart';

/// Application router configuration using GoRouter.
///
/// Features:
/// - Declarative route definitions
/// - Auth redirect guard (protects private routes)
/// - Onboarding flow on first launch
/// - Named routes for type-safe navigation
class AppRouter {
  AppRouter._();

  // ── Route paths ────────────────────────────────────────────────────────────

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String dashboard = '/dashboard';
  static const String configuration = '/configuration';
  static const String profile = '/profile';
  static const String ecommerce = '/ecommerce';
  static const String productDetail = '/product-detail';

  // ── Public routes (no auth required) ───────────────────────────────────────

  static const List<String> _publicRoutes = [
    splash,
    onboarding,
    login,
    forgotPassword,
  ];

  // ── Router instance ────────────────────────────────────────────────────────

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    debugLogDiagnostics: true,
    redirect: _authRedirect,
    routes: [
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: forgotPassword,
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: dashboard,
        name: 'dashboard',
        builder: (context, state) => const AdminLayoutView(),
      ),
      GoRoute(
        path: configuration,
        name: 'configuration',
        builder: (context, state) => const ConfigurationView(),
      ),
      GoRoute(
        path: profile,
        name: 'profile',
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: ecommerce,
        name: 'ecommerce',
        builder: (context, state) => const EcommerceView(),
      ),
      GoRoute(
        path: productDetail,
        name: 'product-detail',
        builder: (context, state) {
          final product = state.extra as Product?;
          if (product == null) {
            return const Scaffold(
              body: Center(child: Text('Product not found')),
            );
          }
          return ProductDetailView(product: product);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Route not found: ${state.uri}'),
      ),
    ),
  );

  // ── Auth redirect guard ────────────────────────────────────────────────────

  static Future<String?> _authRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    final currentPath = state.uri.path;
    final isPublicRoute = _publicRoutes.contains(currentPath);

    // Check if user has valid session
    bool isAuthenticated;
    if (FeatureFlags.useFirebaseAuth) {
      isAuthenticated = await AuthFirebaseDatasource().isAuthenticated();
    } else {
      isAuthenticated = await AuthInjection.repository.isAuthenticated();
    }

    // If authenticated and trying to access login/splash → redirect to dashboard
    if (isAuthenticated && (currentPath == login || currentPath == splash)) {
      return dashboard;
    }

    // If not authenticated and trying to access a protected route → redirect to login
    if (!isAuthenticated && !isPublicRoute) {
      return login;
    }

    return null; // Allow navigation
  }
}
