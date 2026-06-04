import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/widgets/interest_tile.dart';
import 'package:flutter_course/core/widgets/progress_bar.dart';
import 'package:flutter_course/features/pages/core/onboarding/providers/onboarding_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The interests selection page of the onboarding flow.
///
/// Displays a list of selectable interests managed by Riverpod.
class OnboardingInterestsPage extends ConsumerWidget {
  final int currentPage;
  final int totalPages;
  final List<String> interests;
  final Widget button;

  const OnboardingInterestsPage({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.interests,
    required this.button,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedInterests = ref.watch(selectedInterestsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // Progress bar
          ProgressBar(progress: (currentPage + 1) / totalPages),
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
            style: TextStyle(fontSize: 15, color: ArgonColors.muted),
          ),
          const SizedBox(height: 24),

          // Interest list
          Expanded(
            child: ListView.separated(
              itemCount: interests.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final interest = interests[index];
                return InterestTile(
                  label: interest,
                  isSelected: selectedInterests.contains(interest),
                  onTap: () => ref.read(selectedInterestsProvider.notifier).toggle(interest),
                );
              },
            ),
          ),

          const SizedBox(height: 16),
          button,
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
