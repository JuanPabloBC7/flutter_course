import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/routing/app_router.dart';
import 'package:flutter_course/core/utils/validators.dart';
import 'package:flutter_course/core/widgets/form_input.dart';
import 'package:flutter_course/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_course/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _hasAttemptedSubmit = false;

  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() => _hasAttemptedSubmit = true);

    if (!_formKey.currentState!.validate()) return;

    await ref.read(authProvider.notifier).login(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
        );
  }

  void _clearError() {
    ref.read(authProvider.notifier).clearError();
  }

  Widget _buildAnimatedItem({required int index, required Widget child}) {
    final start = (index * 0.1).clamp(0.0, 0.5);
    final end = (start + 0.5).clamp(0.0, 1.0);

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.15),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animController,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      )),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: _animController,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authState = ref.watch(authProvider);
    final isLoading = authState is AuthLoading;
    final isAuthenticated = authState is AuthAuthenticated;
    final errorMessage = authState is AuthError ? authState.message : null;

    // Navigate on success
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next is AuthAuthenticated) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (context.mounted) {
            context.go(AppRouter.dashboard);
          }
        });
      }
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ArgonColors.primary,
              ArgonColors.primary.withValues(alpha: 0.7),
              ArgonColors.bgColorScreen,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.35, 0.55],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              const SizedBox(height: 48),

              // ── Logo / Brand area ──
              _buildAnimatedItem(
                index: 0,
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: ArgonColors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.account_balance_wallet_rounded,
                        color: ArgonColors.white,
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      l10n.welcome,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: ArgonColors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.welcomeQuote,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: ArgonColors.white.withValues(alpha: 0.8),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // ── Login card ──
              _buildAnimatedItem(
                index: 1,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: ArgonColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: ArgonColors.initial.withValues(alpha: 0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.signIn,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: ArgonColors.text,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          l10n.signInSubtitle,
                          style: const TextStyle(
                            fontSize: 13,
                            color: ArgonColors.muted,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Username
                        _buildLabel(l10n.username),
                        const SizedBox(height: 8),
                        FormInput(
                          placeholder: l10n.username,
                          controller: _usernameController,
                          textInputAction: TextInputAction.next,
                          prefixIcon: const Icon(
                            Icons.person_outline_rounded,
                            color: ArgonColors.muted,
                            size: 20,
                          ),
                          autovalidateMode: _hasAttemptedSubmit
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
                          validator: Validators.username,
                          onChanged: (_) => _clearError(),
                        ),
                        const SizedBox(height: 18),

                        // Password
                        _buildLabel(l10n.password),
                        const SizedBox(height: 8),
                        FormInput(
                          placeholder: l10n.password,
                          controller: _passwordController,
                          textInputAction: TextInputAction.done,
                          obscureText: _obscurePassword,
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            color: ArgonColors.muted,
                            size: 20,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: ArgonColors.muted,
                              size: 20,
                            ),
                            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          ),
                          autovalidateMode: _hasAttemptedSubmit
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
                          validator: Validators.password,
                          onChanged: (_) => _clearError(),
                        ),
                        const SizedBox(height: 12),

                        // Forgot password
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => context.push(AppRouter.forgotPassword),
                            child: Text(
                              l10n.forgotPassword,
                              style: const TextStyle(
                                color: ArgonColors.primary,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Error banner
                        if (errorMessage != null)
                          _ErrorBanner(
                            message: errorMessage,
                            onDismiss: _clearError,
                          ),

                        // Success banner
                        if (isAuthenticated)
                          _SuccessBanner(l10n),

                        // Login button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: isLoading || isAuthenticated ? null : _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isAuthenticated
                                  ? ArgonColors.success
                                  : ArgonColors.primary,
                              disabledBackgroundColor: isAuthenticated
                                  ? ArgonColors.success
                                  : ArgonColors.primary.withValues(alpha: 0.6),
                              disabledForegroundColor: ArgonColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: _buildButtonContent(l10n, isLoading, isAuthenticated),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── Divider ──
              _buildAnimatedItem(
                index: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(color: ArgonColors.border.withValues(alpha: 0.6)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        l10n.orContinueWith,
                        style: TextStyle(
                          fontSize: 13,
                          color: ArgonColors.muted.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: ArgonColors.border.withValues(alpha: 0.6)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── Social buttons ──
              _buildAnimatedItem(
                index: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialButton(
                      icon: Icons.g_mobiledata_rounded,
                      label: 'Google',
                      onTap: () {},
                    ),
                    const SizedBox(width: 16),
                    _SocialButton(
                      icon: Icons.apple_rounded,
                      label: 'Apple',
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonContent(AppLocalizations l10n, bool isLoading, bool isAuthenticated) {
    if (isLoading) {
      return const SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          color: ArgonColors.white,
          strokeWidth: 2.5,
        ),
      );
    }
    if (isAuthenticated) {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_rounded, size: 20),
          SizedBox(width: 8),
          Text('Success!', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        ],
      );
    }
    return Text(
      l10n.signIn,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: ArgonColors.text,
      ),
    );
  }
}

// ── Error Banner ─────────────────────────────────────────────────────────────

class _ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onDismiss;

  const _ErrorBanner({required this.message, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: ArgonColors.error.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ArgonColors.error.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline_rounded, color: ArgonColors.error, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontSize: 13, color: ArgonColors.error, height: 1.3),
              ),
            ),
            GestureDetector(
              onTap: onDismiss,
              child: const Icon(Icons.close_rounded, color: ArgonColors.error, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Success Banner ───────────────────────────────────────────────────────────

class _SuccessBanner extends StatelessWidget {
  final AppLocalizations l10n;
  const _SuccessBanner(this.l10n);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: ArgonColors.success.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ArgonColors.success.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle_outline_rounded, color: ArgonColors.success, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                l10n.loginSuccessRedirecting,
                style: const TextStyle(fontSize: 13, color: ArgonColors.success, height: 1.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Social Button ────────────────────────────────────────────────────────────

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: ArgonColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ArgonColors.border, width: 1),
          boxShadow: [
            BoxShadow(
              color: ArgonColors.initial.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: ArgonColors.text, size: 22),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ArgonColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
