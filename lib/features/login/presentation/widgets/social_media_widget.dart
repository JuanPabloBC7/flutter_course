import 'package:flutter/material.dart';
import 'package:flutter_course/core/assets.dart';

class SocialMediaWidget extends StatelessWidget {
  const SocialMediaWidget({super.key, required this.lColor, required this.lImage});

  final Color lColor;
  final String lImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: lColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Image.asset(
          lImage,
          width: 12,
          height: 12,
        ),
      ),
    );
  }

  factory SocialMediaWidget.google () {
    return SocialMediaWidget(lColor: Colors.red, lImage: Assets.googleIcon);
  }

  factory SocialMediaWidget.apple () {
    return SocialMediaWidget(lColor: Colors.black, lImage: Assets.appleIcon);
  }

  factory SocialMediaWidget.facebook () {
    return SocialMediaWidget(lColor: Color(0xFF006FFD), lImage: Assets.facebookIcon);
  }
}