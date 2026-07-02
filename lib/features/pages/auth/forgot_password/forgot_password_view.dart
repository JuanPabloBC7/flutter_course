import 'package:flutter/material.dart';
import 'package:flutter_course/core/config/feature_flags.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/network/app_exceptions.dart';
import 'package:flutter_course/core/routing/app_router.dart';
import 'package:flutter_course/core/utils/validators.dart';
import 'package:flutter_course/core/widgets/form_input.dart';
import 'package:flutter_course/features/auth/data/datasources/auth_firebase_datasource.dart';
import 'package:flutter_course/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  bool _isLoading = false;
  String? _errorMessage;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final AuthFirebaseDatasource _firebaseDatasource = AuthFirebaseDatasource();

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
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword(AppLocalizations l10n) async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (FeatureFlags.useFirebaseAuth) {
        await _firebaseDatasource.sendPasswordResetEmail(email: email);
      } else {
        // Mock delay for non-Firebase mode
        await Future.delayed(const Duration(milliseconds: 600));
      }

      if (!mounted) return;
      setState(() => _isLoading = false);
      _showSuccessDialog(context, l10n);
    } on AppException catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.message;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = l10n.unexpectedError;
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
              const SizedBox(height: 32),

              // ── Back button ──
              _buildAnimatedItem(
                index: 0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: ArgonColors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: ArgonColors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ── Header ──
              _buildAnimatedItem(
                index: 1,
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
                        Icons.lock_reset_rounded,
                        color: ArgonColors.white,
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      l10n.resetPassword,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: ArgonColors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.resetPasswordDescription,
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

              // ── Reset card ──
              _buildAnimatedItem(
                index: 2,
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
                        // Email
                        _buildLabel(l10n.email),
                        const SizedBox(height: 8),
                        FormInput(
                          placeholder: l10n.email,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: ArgonColors.muted,
                            size: 20,
                          ),
                          validator: Validators.email,
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

                        // Reset button
                        ElevatedButton(
                          onPressed: _isLoading ? null : () => _handleResetPassword(l10n),
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
                                l10n.resetPassword,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                        ),
                        const SizedBox(height: 14),

                        // Go back button
                        OutlinedButton(
                          onPressed: () => context.pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: ArgonColors.text,
                            minimumSize: const Size(double.infinity, 52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: const BorderSide(
                              color: ArgonColors.border,
                              width: 1.5,
                            ),
                          ),
                          child: Text(l10n.goBack, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // ── Help text ──
              _buildAnimatedItem(
                index: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 16,
                      color: ArgonColors.muted.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      l10n.checkSpamFolder,
                      style: TextStyle(
                        fontSize: 12,
                        color: ArgonColors.muted.withValues(alpha: 0.7),
                      ),
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

  void _showSuccessDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: ArgonColors.success.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: ArgonColors.success,
                  size: 32,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                l10n.emailSent,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: ArgonColors.text,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.emailSentDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: ArgonColors.muted,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.go(AppRouter.login);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: ArgonColors.white,
                  backgroundColor: ArgonColors.primary,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  l10n.goBack,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
