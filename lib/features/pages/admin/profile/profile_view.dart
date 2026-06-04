import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/providers/user_provider.dart';
import 'package:flutter_course/core/routing/app_router.dart';
import 'package:flutter_course/core/widgets/profile_card.dart';
import 'package:flutter_course/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

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

  String get _fullName => ref.watch(userProfileProvider).valueOrNull?['fullName'] as String? ?? 'User';
  String get _email => ref.watch(userProfileProvider).valueOrNull?['email'] as String? ?? 'email@example.com';
  String get _username => ref.watch(userProfileProvider).valueOrNull?['username'] as String? ?? 'user';
  String get _initials {
    final parts = _fullName.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return _fullName.substring(0, _fullName.length >= 2 ? 2 : 1).toUpperCase();
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
        title: const Text(
          'Profile',
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
              fullName: _fullName,
              email: _email,
              initials: _initials,
              showEditButton: true,
              onEdit: () {},
            ),
          ),

          // ── Personal Information ──
          _buildAnimatedItem(
            index: 1,
            child: const _SectionLabel(title: 'PERSONAL INFORMATION'),
          ),
          _buildAnimatedItem(
            index: 2,
            child: _SettingsGroup(
              children: [
                _ProfileInfoTile(
                  icon: Icons.person_outline_rounded,
                  title: 'Full Name',
                  value: _fullName,
                  color: ArgonColors.primary,
                ),
                _ProfileInfoTile(
                  icon: Icons.alternate_email_rounded,
                  title: 'Username',
                  value: '@$_username',
                  color: ArgonColors.info,
                ),
                _ProfileInfoTile(
                  icon: Icons.email_outlined,
                  title: 'Email',
                  value: _email,
                  color: ArgonColors.success,
                ),
                _ProfileNavTile(
                  icon: Icons.phone_outlined,
                  title: 'Phone Number',
                  subtitle: '+502 **** 1234',
                  color: ArgonColors.warning,
                  onTap: () {},
                ),
                _ProfileNavTile(
                  icon: Icons.calendar_today_outlined,
                  title: 'Date of Birth',
                  subtitle: 'January 15, 1995',
                  color: ArgonColors.label,
                  onTap: () {},
                ),
              ],
            ),
          ),

          // ── Account Settings ──
          _buildAnimatedItem(
            index: 3,
            child: const _SectionLabel(title: 'ACCOUNT SETTINGS'),
          ),
          _buildAnimatedItem(
            index: 4,
            child: _SettingsGroup(
              children: [
                _ProfileNavTile(
                  icon: Icons.lock_outline_rounded,
                  title: 'Change Password',
                  subtitle: 'Update your credentials',
                  color: ArgonColors.error,
                  onTap: () {},
                ),
                _ProfileNavTile(
                  icon: Icons.language_rounded,
                  title: 'Language',
                  subtitle: 'English (US)',
                  color: ArgonColors.info,
                  onTap: () {},
                ),
                _ProfileNavTile(
                  icon: Icons.notifications_none_rounded,
                  title: 'Notifications',
                  subtitle: 'Manage push notifications',
                  color: ArgonColors.primary,
                  onTap: () {},
                ),
              ],
            ),
          ),

          // ── Security ──
          _buildAnimatedItem(
            index: 5,
            child: const _SectionLabel(title: 'SECURITY'),
          ),
          _buildAnimatedItem(
            index: 6,
            child: _SettingsGroup(
              children: [
                _ProfileNavTile(
                  icon: Icons.fingerprint_rounded,
                  title: 'Biometric Authentication',
                  subtitle: 'Fingerprint and Face ID',
                  color: ArgonColors.success,
                  onTap: () {},
                ),
                _ProfileNavTile(
                  icon: Icons.shield_outlined,
                  title: 'Two-Factor Authentication',
                  subtitle: 'Extra layer of security',
                  color: ArgonColors.primary,
                  onTap: () {},
                ),
                _ProfileNavTile(
                  icon: Icons.devices_rounded,
                  title: 'Active Sessions',
                  subtitle: '2 devices connected',
                  color: ArgonColors.warning,
                  onTap: () {},
                ),
              ],
            ),
          ),

          // ── Danger Zone ──
          _buildAnimatedItem(
            index: 7,
            child: const _SectionLabel(title: 'DANGER ZONE'),
          ),
          _buildAnimatedItem(
            index: 8,
            child: _SettingsGroup(
              children: [
                _ProfileNavTile(
                  icon: Icons.logout_rounded,
                  title: 'Log Out',
                  subtitle: 'Sign out of your account',
                  color: ArgonColors.error,
                  onTap: () async {
                    await ref.read(authProvider.notifier).logout();
                    if (!context.mounted) return;
                    context.go(AppRouter.login);
                  },
                ),
                _ProfileNavTile(
                  icon: Icons.delete_outline_rounded,
                  title: 'Delete Account',
                  subtitle: 'Permanently remove your data',
                  color: ArgonColors.error,
                  onTap: () => _showDeleteConfirmation(context),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: ArgonColors.error.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Icon(Icons.warning_amber_rounded, color: ArgonColors.error, size: 28),
              ),
              const SizedBox(height: 16),
              const Text(
                'Delete Account?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: ArgonColors.text),
              ),
              const SizedBox(height: 8),
              const Text(
                'This action cannot be undone. All your data will be permanently removed.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: ArgonColors.muted, height: 1.4),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 44),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        side: const BorderSide(color: ArgonColors.border),
                      ),
                      child: const Text('Cancel', style: TextStyle(fontSize: 14)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ArgonColors.error,
                        minimumSize: const Size(0, 44),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Delete', style: TextStyle(fontSize: 14)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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

// ── Settings Group ───────────────────────────────────────────────────────────

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

// ── Profile Info Tile (read-only display) ────────────────────────────────────

class _ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _ProfileInfoTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
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
                    fontSize: 12,
                    color: ArgonColors.muted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: ArgonColors.text,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Profile Navigation Tile ──────────────────────────────────────────────────

class _ProfileNavTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ProfileNavTile({
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
