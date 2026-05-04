import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/network/app_exceptions.dart';
import 'package:flutter_course/core/network/services.dart';
import 'package:flutter_course/core/widgets/input.dart';
import 'package:flutter_course/l10n/app_localizations.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;
  late AnimationController _animController;

  final AuthService _authService = AuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Please enter username and password.');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _authService.login(username: username, password: password);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/dashboard');
    } on AppException catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.message;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'An unexpected error occurred.';
        _isLoading = false;
      });
    }
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
                      l10n.commonWelcome,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: ArgonColors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.commonQuote,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: ArgonColors.text,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Enter your credentials to continue',
                        style: TextStyle(
                          fontSize: 13,
                          color: ArgonColors.muted,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Username
                      _buildLabel(l10n.commonUsername),
                      const SizedBox(height: 8),
                      Input(
                        placeholder: l10n.commonUsername,
                        controller: _usernameController,
                        prefixIcon: const Icon(Icons.person_outline_rounded,
                            color: ArgonColors.muted, size: 20),
                      ),
                      const SizedBox(height: 18),

                      // Password
                      _buildLabel(l10n.commonPassword),
                      const SizedBox(height: 8),
                      Input(
                        placeholder: l10n.commonPassword,
                        controller: _passwordController,
                        prefixIcon: const Icon(Icons.lock_outline_rounded,
                            color: ArgonColors.muted, size: 20),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: ArgonColors.muted,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(
                                () => _obscurePassword = !_obscurePassword);
                          },
                        ),
                        obscureText: _obscurePassword,
                      ),
                      const SizedBox(height: 12),

                      // Forgot password
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/forgot-password');
                          },
                          child: Text(
                            l10n.commonForgotPassword,
                            style: const TextStyle(
                              color: ArgonColors.primary,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Error message
                      if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: ArgonColors.error.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.error_outline, color: ArgonColors.error, size: 18),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _errorMessage!,
                                    style: const TextStyle(fontSize: 13, color: ArgonColors.error),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Login button
                      ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: ArgonColors.white,
                          backgroundColor: ArgonColors.primary,
                          minimumSize: const Size(double.infinity, 52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: ArgonColors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Text(
                                l10n.commonLogin,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── Divider with "or" ──
              _buildAnimatedItem(
                index: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                          color: ArgonColors.border.withValues(alpha: 0.6)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'or continue with',
                        style: TextStyle(
                          fontSize: 13,
                          color: ArgonColors.muted.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                          color: ArgonColors.border.withValues(alpha: 0.6)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── Social login buttons ──
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

// ── Social Login Button ──────────────────────────────────────────────────────

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
