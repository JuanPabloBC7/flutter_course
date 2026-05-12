import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/widgets/page_dots_indicator.dart';

/// A full onboarding page with an image on top and text content below.
///
/// Used for pages 1 and 3 of the onboarding flow.
class OnboardingImagePage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final int currentPage;
  final int totalPages;
  final Widget button;

  const OnboardingImagePage({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.currentPage,
    required this.totalPages,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
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
                PageDotsIndicator(currentPage: currentPage, totalPages: totalPages),
                const SizedBox(height: 24),
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
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 15,
                    color: ArgonColors.muted,
                    height: 1.5,
                  ),
                ),
                const Spacer(),
                button,
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
