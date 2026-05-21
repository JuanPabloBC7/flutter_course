import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/routing/app_router.dart';
import 'package:flutter_course/core/widgets/onboarding_image_page.dart';
import 'package:flutter_course/core/widgets/onboarding_interests_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Onboarding screen shown on first app launch.
///
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

  static const List<String> _interests = [
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
    context.go(AppRouter.ecommerce);
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
            // Page 1: Image page
            OnboardingImagePage(
              imageUrl: 'https://dummyjson.com/image/400x400',
              title: 'Create a prototype in just a few minutes',
              subtitle: 'Enjoy these pre-made components and worry only about creating the best product ever.',
              currentPage: 0,
              totalPages: _totalPages,
              button: _buildNextButton(),
            ),

            // Page 2: Interests selection
            OnboardingInterestsPage(
              currentPage: 1,
              totalPages: _totalPages,
              interests: _interests,
              button: _buildNextButton(),
            ),

            // Page 3: Image page
            OnboardingImagePage(
              imageUrl: 'https://dummyjson.com/image/400x400',
              title: 'Secure and reliable banking',
              subtitle: 'Your data is protected with industry-standard encryption and biometric authentication.',
              currentPage: 2,
              totalPages: _totalPages,
              button: _buildNextButton(),
            ),
          ],
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
