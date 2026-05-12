import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/routing/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Onboarding screen shown on first app launch.
/// After completing, navigates to login and marks onboarding as seen.
class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingPage> _pages = const [
    _OnboardingPage(
      imageUrl: '',
      title: 'Create a prototype in just a few minutes',
      subtitle: 'Enjoy these pre-made components and worry only about creating the best product ever.',
    ),
    _OnboardingPage(
      imageUrl: '',
      title: 'Manage your finances with ease',
      subtitle: 'Track your expenses, transfers, and savings all in one place with a clean interface.',
    ),
    _OnboardingPage(
      imageUrl: 'https://dummyjson.com/image/400x400',
      title: 'Secure and reliable banking',
      subtitle: 'Your data is protected with industry-standard encryption and biometric authentication.',
    ),
  ];

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    if (!mounted) return;
    context.go(AppRouter.login);
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArgonColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Page content (image + text) ──
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Column(
                    children: [
                      // Image section (~60% of screen)
                      Expanded(
                        flex: 6,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ArgonColors.primary.withValues(alpha: 0.06),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(32),
                              bottomRight: Radius.circular(32),
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            ),
                          ),
                          child: Center(
                            child: Image.network(
                              page.imageUrl,
                              width: MediaQuery.of(context).size.width * 0.7,
                              fit: BoxFit.contain,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: ArgonColors.primary,
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.image_outlined, size: 64, color: ArgonColors.muted);
                              },
                            ),
                          ),
                        ),
                      ),

                      // Text section (~40% of screen)
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Dots indicator
                              Row(
                                children: List.generate(
                                  _pages.length,
                                  (i) => Container(
                                    width: i == _currentPage ? 10 : 8,
                                    height: i == _currentPage ? 10 : 8,
                                    margin: const EdgeInsets.only(right: 6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: i == _currentPage
                                          ? ArgonColors.primary
                                          : ArgonColors.border,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Title
                              Text(
                                page.title,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                  color: ArgonColors.text,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Subtitle
                              Text(
                                page.subtitle,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: ArgonColors.muted,
                                  height: 1.5,
                                ),
                              ),

                              const Spacer(),

                              // Button
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: ElevatedButton(
                                  onPressed: _nextPage,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ArgonColors.primary,
                                    foregroundColor: ArgonColors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    _currentPage < _pages.length - 1 ? 'Next' : 'Get Started',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Page data model ──────────────────────────────────────────────────────────

class _OnboardingPage {
  final String imageUrl;
  final String title;
  final String subtitle;

  const _OnboardingPage({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });
}
