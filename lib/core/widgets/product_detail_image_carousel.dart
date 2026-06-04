import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';

/// Product detail image carousel with page indicators
class ProductDetailImageCarousel extends StatefulWidget {
  final List<String> images;
  final VoidCallback? onClose;
  final double height;

  const ProductDetailImageCarousel({
    super.key,
    required this.images,
    this.onClose,
    this.height = 300,
  });

  @override
  State<ProductDetailImageCarousel> createState() =>
      _ProductDetailImageCarouselState();
}

class _ProductDetailImageCarouselState extends State<ProductDetailImageCarousel> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Carousel
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return Container(
                color: ArgonColors.secondary,
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
        // Close button
        Positioned(
          top: 16,
          left: 16,
          child: GestureDetector(
            onTap: widget.onClose,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: ArgonColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ArgonColors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Icon(
                Icons.close,
                color: ArgonColors.text,
                size: 20,
              ),
            ),
          ),
        ),
        // Dot indicators
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Row(
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
                      : ArgonColors.secondary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
