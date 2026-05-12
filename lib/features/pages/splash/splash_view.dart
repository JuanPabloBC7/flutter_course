import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/routing/app_router.dart';
import 'package:flutter_course/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Splash screen shown on app startup.
///
/// Flow:
/// 1. If onboarding not completed → onboarding
/// 2. If authenticated → dashboard
/// 3. Otherwise → login
class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animController.forward();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;

    // Check if onboarding was completed
    final prefs = await SharedPreferences.getInstance();
    final onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

    if (!onboardingCompleted) {
      if (mounted) context.go(AppRouter.onboarding);
      return;
    }

    // Check session
    await ref.read(authProvider.notifier).checkSession();

    if (!mounted) return;

    final isAuthenticated = ref.read(authProvider) is AuthAuthenticated;

    if (isAuthenticated) {
      context.go(AppRouter.dashboard);
    } else {
      context.go(AppRouter.login);
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ArgonColors.primary,
              ArgonColors.primary.withValues(alpha: 0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: _animController,
            curve: Curves.easeOut,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App icon
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: ArgonColors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_rounded,
                  color: ArgonColors.white,
                  size: 44,
                ),
              ),
              const SizedBox(height: 24),
              // App name
              const Text(
                'BAM Wallet',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: ArgonColors.white,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Secure Banking',
                style: TextStyle(
                  fontSize: 14,
                  color: ArgonColors.white.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 48),
              // Loading indicator
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: ArgonColors.white,
                  strokeWidth: 2.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
