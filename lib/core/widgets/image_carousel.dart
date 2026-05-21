import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';

/// A reusable carousel widget that displays images with dot indicators
class ImageCarousel extends StatefulWidget {
  /// List of image URLs or asset paths
  final List<String> images;

  /// Height of the carousel
  final double height;

  /// Callback when an image is tapped
  final Function(int)? onImageTap;

  /// Autoplay duration, null to disable autoplay
  final Duration? autoplayDuration;

  const ImageCarousel({
    super.key,
    required this.images,
    this.height = 250,
    this.onImageTap,
    this.autoplayDuration,
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Setup autoplay if duration is provided
    if (widget.autoplayDuration != null) {
      _startAutoplay();
    }
  }

  void _startAutoplay() {
    Future.delayed(widget.autoplayDuration!).then((_) {
      if (mounted) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Carousel Images
        GestureDetector(
          onTap: () => widget.onImageTap?.call(_currentPage),
          child: SizedBox(
            height: widget.height,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });

                // Restart autoplay on manual swipe
                if (widget.autoplayDuration != null) {
                  _startAutoplay();
                }
              },
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ArgonColors.secondary,
                  ),
                  child: widget.images[index].startsWith('http')
                      ? Image.network(
                          widget.images[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.image,
                                size: 64,
                                color: ArgonColors.muted,
                              ),
                            );
                          },
                        )
                      : Image.asset(
                          widget.images[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.image,
                                size: 64,
                                color: ArgonColors.muted,
                              ),
                            );
                          },
                        ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Dot Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.images.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? ArgonColors.primary
                    : ArgonColors.muted,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
