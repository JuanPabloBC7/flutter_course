import 'package:flutter/material.dart';
import 'package:flutter_course/core/config/feature_flags.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/providers/locale_provider.dart';
import 'package:flutter_course/core/providers/role_provider.dart';
import 'package:flutter_course/core/providers/user_provider.dart';
import 'package:flutter_course/core/routing/app_router.dart';
import 'package:flutter_course/core/widgets/language_sheet.dart';
import 'package:flutter_course/core/widgets/profile_card.dart';
import 'package:flutter_course/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_course/features/pages/admin/dashboard/dashboard_view.dart';
import 'package:flutter_course/features/pages/admin/history/history_view.dart';
import 'package:flutter_course/features/pages/admin/trasnfers/trasnfers_view.dart';
import 'package:flutter_course/l10n/app_localizations.dart';
import 'package:flutter_course/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminLayoutView extends ConsumerStatefulWidget {
  const AdminLayoutView({super.key});

  @override
  ConsumerState<AdminLayoutView> createState() => _AdminLayoutViewState();
}

class _AdminLayoutViewState extends ConsumerState<AdminLayoutView> {
  int _currentIndex = 0;
  bool _notificationStarted = false;

  final List<Widget> _pages = const [
    DashboardView(),
    TransfersView(),
    HistoryView(),
    _MenuView(),
  ];

  @override
  void initState() {
    super.initState();
    _initNotifications();
  }

  /// Inicia el servicio de notificaciones de órdenes según el rol del usuario.
  Future<void> _initNotifications() async {
    if (_notificationStarted) return;
    _notificationStarted = true;

    // Esperar a que el rol se cargue
    final role = await ref.read(userRoleProvider.future);
    orderNotificationService.startListening(
      role: role,
      messengerKey: scaffoldMessengerKey,
    );
  }

  @override
  void dispose() {
    orderNotificationService.stop();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard_outlined),
            activeIcon: const Icon(Icons.dashboard),
            label: l10n.navDashboard,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.swap_horiz_outlined),
            activeIcon: const Icon(Icons.swap_horiz),
            label: l10n.navTransfers,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.history_outlined),
            activeIcon: const Icon(Icons.history),
            label: l10n.navHistory,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu_outlined),
            activeIcon: const Icon(Icons.menu),
            label: l10n.navMenu,
          ),
        ],
      ),
    );
  }
}

// ── Menu View ────────────────────────────────────────────────────────────────

class _MenuView extends ConsumerWidget {
  const _MenuView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final userData = ref.watch(userProfileProvider).valueOrNull;
    final fullName = userData?['fullName'] as String? ?? 'User';
    final email = userData?['email'] as String? ?? 'email@example.com';

    String initials() {
      final parts = fullName.trim().split(' ');
      if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
      return fullName.substring(0, fullName.length >= 2 ? 2 : 1).toUpperCase();
    }

    void navigateToTab(int index) {
      final state = context.findAncestorStateOfType<_AdminLayoutViewState>();
      state?._onTabTapped(index);
    }

    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      appBar: AppBar(
        backgroundColor: ArgonColors.white,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          l10n.menuTitle,
          style: const TextStyle(
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
          ProfileCard(fullName: fullName, email: email, initials: initials()),

          _MenuSectionLabel(title: l10n.navigation),
          _MenuGroup(
            children: [
              _MenuTile(
                icon: Icons.dashboard_rounded,
                title: l10n.menuDashboard,
                subtitle: l10n.menuDashboardSubtitle,
                color: ArgonColors.primary,
                onTap: () => navigateToTab(0),
              ),
              _MenuTile(
                icon: Icons.swap_horiz_rounded,
                title: l10n.menuTransfers,
                subtitle: l10n.menuTransfersSubtitle,
                color: ArgonColors.info,
                onTap: () => navigateToTab(1),
              ),
              _MenuTile(
                icon: Icons.history_rounded,
                title: l10n.menuHistory,
                subtitle: l10n.menuHistorySubtitle,
                color: ArgonColors.success,
                onTap: () => navigateToTab(2),
              ),
              _MenuTile(
                icon: Icons.storefront_rounded,
                title: l10n.menuEcommerce,
                subtitle: l10n.menuEcommerceSubtitle,
                color: ArgonColors.label,
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  final onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;
                  if (!context.mounted) return;
                  if (onboardingCompleted) {
                    if (FeatureFlags.useOnboardingLogic) {
                      context.push(AppRouter.ecommerce);
                    } else {
                      context.push(AppRouter.onboarding);
                    }
                  } else {
                    context.push(AppRouter.onboarding);
                  }
                },
              ),
              _MenuTile(
                icon: Icons.settings_rounded,
                title: l10n.menuConfiguration,
                subtitle: l10n.menuConfigurationSubtitle,
                color: ArgonColors.warning,
                onTap: () => context.push(AppRouter.configuration),
              ),
            ],
          ),

          _MenuSectionLabel(title: l10n.accountSection),
          _MenuGroup(
            children: [
              _MenuTile(
                icon: Icons.person_outline_rounded,
                title: l10n.menuProfile,
                subtitle: l10n.menuProfileSubtitle,
                color: ArgonColors.primary,
                onTap: () => context.push(AppRouter.profile),
              ),
              _MenuTile(
                icon: Icons.notifications_none_rounded,
                title: l10n.menuNotifications,
                subtitle: l10n.menuNotificationsSubtitle,
                color: ArgonColors.info,
                onTap: () {},
              ),
              _MenuTile(
                icon: Icons.language_rounded,
                title: l10n.menuLanguage,
                subtitle: ref.watch(localeProvider.notifier).currentLanguageName,
                color: ArgonColors.info,
                onTap: () => LanguageSheet.show(context, ref),
              ),
              _MenuTile(
                icon: Icons.shield_outlined,
                title: l10n.menuPrivacySecurity,
                subtitle: l10n.menuPrivacySecuritySubtitle,
                color: ArgonColors.success,
                onTap: () {},
              ),
            ],
          ),

          _MenuSectionLabel(title: l10n.supportSection),
          _MenuGroup(
            children: [
              _MenuTile(
                icon: Icons.help_outline_rounded,
                title: l10n.menuHelpCenter,
                subtitle: l10n.menuHelpCenterSubtitle,
                color: ArgonColors.primary,
                onTap: () {},
              ),
              _MenuTile(
                icon: Icons.chat_bubble_outline_rounded,
                title: l10n.menuContactUs,
                subtitle: l10n.menuContactUsSubtitle,
                color: ArgonColors.info,
                onTap: () {},
              ),
              _MenuTile(
                icon: Icons.info_outline_rounded,
                title: l10n.menuAbout,
                subtitle: l10n.menuAboutSubtitle,
                color: ArgonColors.muted,
                onTap: () {},
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: ElevatedButton(
              onPressed: () async {
                await ref.read(authProvider.notifier).logout();
                if (!context.mounted) return;
                context.go(AppRouter.login);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: ArgonColors.white,
                backgroundColor: ArgonColors.error,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.logout_rounded, size: 20),
                  const SizedBox(width: 8),
                  Text(l10n.logOut, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
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

// ── Menu Group ───────────────────────────────────────────────────────────────

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
                Divider(height: 1, indent: 60, color: ArgonColors.border.withValues(alpha: 0.5)),
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

  const _MenuTile({required this.icon, required this.title, required this.subtitle, required this.color, required this.onTap});

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
                decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: ArgonColors.text)),
                    const SizedBox(height: 1),
                    Text(subtitle, style: const TextStyle(fontSize: 12, color: ArgonColors.muted)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: ArgonColors.muted, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}
