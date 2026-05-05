import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/network/services.dart';
import 'package:flutter_course/core/widgets/profile_card.dart';
import 'package:flutter_course/features/auth/auth_injection.dart';
import 'package:flutter_course/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_course/features/pages/admin/configuration/configuration_view.dart';
import 'package:flutter_course/features/pages/admin/dashboard/dashboard_view.dart';
import 'package:flutter_course/features/pages/admin/history/history_view.dart';
import 'package:flutter_course/features/pages/admin/profile/profile_view.dart';
import 'package:flutter_course/features/pages/admin/trasnfers/trasnfers_view.dart';

class AdminLayoutView extends StatefulWidget {
  const AdminLayoutView({super.key});

  @override
  State<AdminLayoutView> createState() => _AdminLayoutViewState();
}

class _AdminLayoutViewState extends State<AdminLayoutView> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DashboardView(),
    TransfersView(),
    HistoryView(),
    _MenuView(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ArgonColors.primary,
        unselectedItemColor: ArgonColors.muted,
        backgroundColor: ArgonColors.white,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz_outlined),
            activeIcon: Icon(Icons.swap_horiz),
            label: 'Transfers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_outlined),
            activeIcon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}

class _MenuView extends StatefulWidget {
  const _MenuView();

  @override
  State<_MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<_MenuView> {
  final UserService _userService = UserService();
  final LogoutUseCase _logoutUseCase = AuthInjection.logoutUseCase;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final data = await _userService.fetchUser();
      if (!mounted) return;
      setState(() => _userData = data);
    } catch (_) {
      // Fallback to defaults
    }
  }

  String get _fullName => _userData?['fullName'] as String? ?? 'User';
  String get _email => _userData?['email'] as String? ?? 'email@example.com';
  String get _initials {
    final parts = _fullName.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return _fullName.substring(0, _fullName.length >= 2 ? 2 : 1).toUpperCase();
  }

  Future<void> _handleLogout() async {
    try {
      await _logoutUseCase.execute();
    } catch (_) {
      // Proceed with navigation even if logout API fails
    }
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      appBar: AppBar(
        backgroundColor: ArgonColors.white,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const Text(
          'Menu',
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
          // ── Profile header ──
          ProfileCard(
            fullName: _fullName,
            email: _email,
            initials: _initials,
          ),

          // ── Navigation section ──
          const _MenuSectionLabel(title: 'NAVIGATION'),
          _MenuGroup(
            children: [
              _MenuTile(
                icon: Icons.dashboard_rounded,
                title: 'Dashboard',
                subtitle: 'Overview and statistics',
                color: ArgonColors.primary,
                onTap: () => _navigateToTab(context, 0),
              ),
              _MenuTile(
                icon: Icons.swap_horiz_rounded,
                title: 'Transfers',
                subtitle: 'Send and receive transfers',
                color: ArgonColors.info,
                onTap: () => _navigateToTab(context, 1),
              ),
              _MenuTile(
                icon: Icons.history_rounded,
                title: 'History',
                subtitle: 'View past transactions',
                color: ArgonColors.success,
                onTap: () => _navigateToTab(context, 2),
              ),
              _MenuTile(
                icon: Icons.settings_rounded,
                title: 'Configuration',
                subtitle: 'App settings and preferences',
                color: ArgonColors.warning,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ConfigurationView()),
                  );
                },
              ),
            ],
          ),

          // ── Account section ──
          const _MenuSectionLabel(title: 'ACCOUNT'),
          _MenuGroup(
            children: [
              _MenuTile(
                icon: Icons.person_outline_rounded,
                title: 'Profile',
                subtitle: 'View and edit your profile',
                color: ArgonColors.primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileView()),
                  );
                },
              ),
              _MenuTile(
                icon: Icons.notifications_none_rounded,
                title: 'Notifications',
                subtitle: 'Manage your alerts',
                color: ArgonColors.info,
                onTap: () {},
              ),
              _MenuTile(
                icon: Icons.shield_outlined,
                title: 'Privacy & Security',
                subtitle: 'Protect your account',
                color: ArgonColors.success,
                onTap: () {},
              ),
            ],
          ),

          // ── Support section ──
          const _MenuSectionLabel(title: 'SUPPORT'),
          _MenuGroup(
            children: [
              _MenuTile(
                icon: Icons.help_outline_rounded,
                title: 'Help Center',
                subtitle: 'FAQ and guides',
                color: ArgonColors.primary,
                onTap: () {},
              ),
              _MenuTile(
                icon: Icons.chat_bubble_outline_rounded,
                title: 'Contact Us',
                subtitle: 'Get in touch with support',
                color: ArgonColors.info,
                onTap: () {},
              ),
              _MenuTile(
                icon: Icons.info_outline_rounded,
                title: 'About',
                subtitle: 'Version 1.0.0',
                color: ArgonColors.muted,
                onTap: () {},
              ),
            ],
          ),

          // ── Logout ──
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: ElevatedButton(
              onPressed: _handleLogout,
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

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _navigateToTab(BuildContext context, int index) {
    final state = context.findAncestorStateOfType<_AdminLayoutViewState>();
    state?._onTabTapped(index);
  }
}

// ── Menu Section Label ───────────────────────────────────────────────────────

class _MenuSectionLabel extends StatelessWidget {
  final String title;

  const _MenuSectionLabel({required this.title});

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

// ── Menu Group (card container) ──────────────────────────────────────────────

class _MenuGroup extends StatelessWidget {
  final List<Widget> children;

  const _MenuGroup({required this.children});

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

// ── Menu Tile ────────────────────────────────────────────────────────────────

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _MenuTile({
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
