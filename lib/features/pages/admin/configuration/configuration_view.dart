import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/providers/user_provider.dart';
import 'package:flutter_course/core/widgets/profile_card.dart';
import 'package:flutter_course/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfigurationView extends ConsumerStatefulWidget {
  const ConfigurationView({super.key});

  @override
  ConsumerState<ConfigurationView> createState() => _ConfigurationViewState();
}

class _ConfigurationViewState extends ConsumerState<ConfigurationView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  // Toggle states
  bool _notificationsEnabled = true;
  bool _biometricEnabled = false;
  bool _darkModeEnabled = false;
  bool _autoSaveEnabled = true;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Widget _buildAnimatedItem({required int index, required Widget child}) {
    final start = (index * 0.08).clamp(0.0, 0.6);
    final end = (start + 0.4).clamp(0.0, 1.0);

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.12),
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
    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      appBar: AppBar(
        backgroundColor: ArgonColors.white,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: true,
        title: const Text(
          'Configuration',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ArgonColors.text,
          ),
        ),
      ),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // ── Profile card ──
          _buildAnimatedItem(
            index: 0,
            child: ProfileCard(
              fullName: ref.watch(userProfileProvider).valueOrNull?['fullName'] as String? ?? 'User',
              email: ref.watch(userProfileProvider).valueOrNull?['email'] as String? ?? 'email@example.com',
            ),
          ),

          // ── General section ──
          _buildAnimatedItem(
            index: 1,
            child: const _SectionLabel(title: 'GENERAL'),
          ),
          _buildAnimatedItem(
            index: 2,
            child: _SettingsGroup(
              children: [
                _SettingsToggleTile(
                  icon: Icons.notifications_none_rounded,
                  title: 'Notifications',
                  subtitle: 'Push and in-app alerts',
                  color: ArgonColors.primary,
                  value: _notificationsEnabled,
                  onChanged: (v) =>
                      setState(() => _notificationsEnabled = v),
                ),
                _SettingsToggleTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  subtitle: 'Switch appearance theme',
                  color: ArgonColors.initial,
                  value: _darkModeEnabled,
                  onChanged: (v) =>
                      setState(() => _darkModeEnabled = v),
                ),
                _SettingsNavTile(
                  icon: Icons.language_rounded,
                  title: 'Language',
                  subtitle: 'English (US)',
                  color: ArgonColors.info,
                  onTap: () {},
                ),
                _SettingsNavTile(
                  icon: Icons.palette_outlined,
                  title: 'Appearance',
                  subtitle: 'Colors and layout',
                  color: ArgonColors.warning,
                  onTap: () {},
                ),
              ],
            ),
          ),

          // ── Security section ──
          _buildAnimatedItem(
            index: 3,
            child: const _SectionLabel(title: 'SECURITY'),
          ),
          _buildAnimatedItem(
            index: 4,
            child: _SettingsGroup(
              children: [
                _SettingsToggleTile(
                  icon: Icons.fingerprint_rounded,
                  title: 'Biometric Login',
                  subtitle: 'Use fingerprint or face ID',
                  color: ArgonColors.success,
                  value: _biometricEnabled,
                  onChanged: (v) =>
                      setState(() => _biometricEnabled = v),
                ),
                _SettingsNavTile(
                  icon: Icons.lock_outline_rounded,
                  title: 'Change Password',
                  subtitle: 'Update your credentials',
                  color: ArgonColors.error,
                  onTap: () {},
                ),
                _SettingsNavTile(
                  icon: Icons.shield_outlined,
                  title: 'Two-Factor Auth',
                  subtitle: 'Extra layer of security',
                  color: ArgonColors.primary,
                  onTap: () {},
                ),
              ],
            ),
          ),

          // ── Data & Storage section ──
          _buildAnimatedItem(
            index: 5,
            child: const _SectionLabel(title: 'DATA & STORAGE'),
          ),
          _buildAnimatedItem(
            index: 6,
            child: _SettingsGroup(
              children: [
                _SettingsToggleTile(
                  icon: Icons.save_outlined,
                  title: 'Auto-Save',
                  subtitle: 'Save transactions automatically',
                  color: ArgonColors.info,
                  value: _autoSaveEnabled,
                  onChanged: (v) =>
                      setState(() => _autoSaveEnabled = v),
                ),
                _SettingsNavTile(
                  icon: Icons.storage_rounded,
                  title: 'Storage Usage',
                  subtitle: '24.5 MB used',
                  color: ArgonColors.warning,
                  onTap: () {},
                ),
                _SettingsNavTile(
                  icon: Icons.download_outlined,
                  title: 'Export Data',
                  subtitle: 'Download your information',
                  color: ArgonColors.success,
                  onTap: () {},
                ),
              ],
            ),
          ),

          // ── Support section ──
          _buildAnimatedItem(
            index: 7,
            child: const _SectionLabel(title: 'SUPPORT'),
          ),
          _buildAnimatedItem(
            index: 8,
            child: _SettingsGroup(
              children: [
                _SettingsNavTile(
                  icon: Icons.help_outline_rounded,
                  title: 'Help Center',
                  subtitle: 'FAQ and guides',
                  color: ArgonColors.primary,
                  onTap: () {},
                ),
                _SettingsNavTile(
                  icon: Icons.chat_bubble_outline_rounded,
                  title: 'Contact Support',
                  subtitle: 'Get in touch with us',
                  color: ArgonColors.info,
                  onTap: () {},
                ),
                _SettingsNavTile(
                  icon: Icons.info_outline_rounded,
                  title: 'About',
                  subtitle: 'Version 1.0.0',
                  color: ArgonColors.muted,
                  onTap: () {},
                ),
              ],
            ),
          ),

          // ── Logout button ──
          _buildAnimatedItem(
            index: 9,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: ElevatedButton(
                onPressed: () async {
                  await ref.read(authProvider.notifier).logout();
                  if (!context.mounted) return;
                  Navigator.pushReplacementNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: ArgonColors.white,
                  backgroundColor: ArgonColors.error,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout_rounded, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ── Section Label ────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String title;

  const _SectionLabel({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 10, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: ArgonColors.muted,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ── Settings Group (card container) ──────────────────────────────────────────

class _SettingsGroup extends StatelessWidget {
  final List<Widget> children;

  const _SettingsGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ArgonColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: ArgonColors.initial.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: List.generate(children.length, (index) {
          return Column(
            children: [
              children[index],
              if (index < children.length - 1)
                Divider(
                  height: 1,
                  indent: 60,
                  color: ArgonColors.border.withValues(alpha: 0.5),
                ),
            ],
          );
        }),
      ),
    );
  }
}

// ── Settings Toggle Tile ─────────────────────────────────────────────────────

class _SettingsToggleTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsToggleTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: ArgonColors.text,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: ArgonColors.muted,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeTrackColor: ArgonColors.primary.withValues(alpha: 0.3),
            thumbColor: WidgetStateProperty.all(ArgonColors.primary),
          ),
        ],
      ),
    );
  }
}

// ── Settings Navigation Tile ─────────────────────────────────────────────────

class _SettingsNavTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _SettingsNavTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: ArgonColors.text,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: ArgonColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: ArgonColors.muted,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
