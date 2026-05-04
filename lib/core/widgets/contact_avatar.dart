import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';

class ContactAvatar extends StatelessWidget {
  final String name;
  final Color? color;
  final double size;
  final VoidCallback? onTap;
  final bool showLabel;

  const ContactAvatar({
    super.key,
    required this.name,
    this.color,
    this.size = 52,
    this.onTap,
    this.showLabel = true,
  });

  String get _initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final avatarColor = color ?? ArgonColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: avatarColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(size / 2),
            ),
            child: Center(
              child: Text(
                _initials,
                style: TextStyle(
                  fontSize: size * 0.34,
                  fontWeight: FontWeight.w700,
                  color: avatarColor,
                ),
              ),
            ),
          ),
          if (showLabel) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: size + 16,
              child: Text(
                name.split(' ').first,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: ArgonColors.text,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
