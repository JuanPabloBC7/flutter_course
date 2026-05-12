import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/routing/app_router.dart';
import 'package:flutter_course/features/pages/onboarding/providers/onboarding_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Onboarding screen shown on first app launch.
/// Page 1: Welcome with image
/// Page 2: Interest selection (Riverpod state management)
/// Page 3: Final message with image
class OnboardingView extends ConsumerStatefulWidget {
  const OnboardingView({super.key});

  @override
  ConsumerState<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  static const int _totalPages = 3;

  final List<String> _interests = const [
    'User Interface',
    'User Experience',
    'User Research',
    'UX Writing',
    'User Testing',
    'Service Design',
    'Strategy',
    'Design Systems',
  ];

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    if (!mounted) return;
    context.go(AppRouter.login);
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
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
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) => setState(() => _currentPage = index),
          children: [
            _buildImagePage(
              imageUrl: 'https://dummyjson.com/image/400x400',
              title: 'Create a prototype in just a few minutes',
              subtitle: 'Enjoy these pre-made components and worry only about creating the best product ever.',
            ),
            _buildInterestsPage(),
            _buildImagePage(
              imageUrl: 'https://dummyjson.com/image/400x400',
              title: 'Secure and reliable banking',
              subtitle: 'Your data is protected with industry-standard encryption and biometric authentication.',
            ),
          ],
        ),
      ),
    );
  }

  // ── Page 1 & 3: Image page ─────────────────────────────────────────────────

  Widget _buildImagePage({
    required String imageUrl,
    required String title,
    required String subtitle,
  }) {
    return Column(
      children: [
        // Image section (60%)
        Expanded(
          flex: 6,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: ArgonColors.primary.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Center(
              child: Image.network(
                imageUrl,
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

        // Text section (40%)
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dots
                _buildDots(),
                const SizedBox(height: 24),

                // Title
                Text(
                  title,
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
                  subtitle,
                  style: const TextStyle(
                    fontSize: 15,
                    color: ArgonColors.muted,
                    height: 1.5,
                  ),
                ),

                const Spacer(),

                // Button
                _buildNextButton(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Page 2: Interests selection ────────────────────────────────────────────

  Widget _buildInterestsPage() {
    final selectedInterests = ref.watch(selectedInterestsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // Progress bar
          _buildProgressBar(),
          const SizedBox(height: 32),

          // Title
          const Text(
            'Personalise your\nexperience',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: ArgonColors.text,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),

          // Subtitle
          const Text(
            'Choose your interests.',
            style: TextStyle(
              fontSize: 15,
              color: ArgonColors.muted,
            ),
          ),
          const SizedBox(height: 24),

          // Interest list
          Expanded(
            child: ListView.separated(
              itemCount: _interests.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final interest = _interests[index];
                final isSelected = selectedInterests.contains(interest);

                return GestureDetector(
                  onTap: () => ref.read(selectedInterestsProvider.notifier).toggle(interest),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? ArgonColors.primary.withValues(alpha: 0.06)
                          : ArgonColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? ArgonColors.primary.withValues(alpha: 0.3)
                            : ArgonColors.border,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            interest,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              color: ArgonColors.text,
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_rounded,
                            color: ArgonColors.primary,
                            size: 22,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Button
          _buildNextButton(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ── Shared widgets ─────────────────────────────────────────────────────────

  Widget _buildDots() {
    return Row(
      children: List.generate(
        _totalPages,
        (i) => Container(
          width: i == _currentPage ? 10 : 8,
          height: i == _currentPage ? 10 : 8,
          margin: const EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == _currentPage ? ArgonColors.primary : ArgonColors.border,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress = (_currentPage + 1) / _totalPages;

    return Container(
      height: 6,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ArgonColors.border.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(3),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: ArgonColors.primary,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
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
          _currentPage < _totalPages - 1 ? 'Next' : 'Get Started',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
