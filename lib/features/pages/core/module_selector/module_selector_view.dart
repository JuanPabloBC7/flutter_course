import 'package:flutter/material.dart';
import 'package:flutter_course/core/config/feature_flags.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/routing/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModuleSelectorView extends StatelessWidget {
  const ModuleSelectorView({super.key});

  // void _navigateToAdmin(BuildContext context) {
  //   context.go(AppRouter.login);
  // }

  void _navigateToEcommerce(BuildContext context) async {
    // Check if onboarding was completed
    final prefs = await SharedPreferences.getInstance();
    final onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

    if (!context.mounted) return;

    if (FeatureFlags.useOnboardingLogic) {
      context.go(
        onboardingCompleted
          ? AppRouter.ecommerce
          : AppRouter.onboarding,
      );
    } else {
      context.go(
        onboardingCompleted
          ? AppRouter.onboarding
          : AppRouter.onboarding,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Selecciona un módulo',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: ArgonColors.text,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Elige dónde deseas ingresar para continuar con tu experiencia.',
                style: TextStyle(
                  fontSize: 16,
                  color: ArgonColors.header,
                ),
              ),
              const SizedBox(height: 32),
              _buildModuleCard(
                context,
                title: 'Página Administrativa',
                subtitle: 'Accede al flujo de administración y login.',
                icon: Icons.dashboard_customize_outlined,
                // onTap: () => _navigateToAdmin(context),
                onTap: () => context.go(AppRouter.login),
              ),
              const SizedBox(height: 16),
              _buildModuleCard(
                context,
                title: 'E-commerce',
                subtitle: 'Explora productos con onboarding dedicado.',
                icon: Icons.shopping_bag_outlined,
                onTap: () => _navigateToEcommerce(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModuleCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: ArgonColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: ArgonColors.black.withValues(alpha: 0.05),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: ArgonColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: ArgonColors.primary, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: ArgonColors.text,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: ArgonColors.header,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 18, color: ArgonColors.muted),
            ],
          ),
        ),
      ),
    );
  }
}
