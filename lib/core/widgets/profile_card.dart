import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';

/// Reusable profile card widget with gradient background.
///
/// Used in Menu, Configuration, and Profile views.
/// Shows user avatar (initials), full name, email, and an optional edit button.
class ProfileCard extends StatelessWidget {
  final String fullName;
  final String email;
  final String? initials;
  final bool showEditButton;
  final VoidCallback? onEdit;

  const ProfileCard({
    super.key,
    required this.fullName,
    required this.email,
    this.initials,
    this.showEditButton = false,
    this.onEdit,
  });

  String get _initials {
    if (initials != null) return initials!;
    final parts = fullName.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return fullName.substring(0, fullName.length >= 2 ? 2 : 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 4),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ArgonColors.primary,
            ArgonColors.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ArgonColors.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: ArgonColors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Center(
              child: Text(
                _initials,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: ArgonColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: ArgonColors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          if (showEditButton)
            GestureDetector(
              onTap: onEdit,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: ArgonColors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.edit_outlined,
                  color: ArgonColors.white,
                  size: 18,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
