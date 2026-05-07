import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/widgets/contact_avatar.dart';

/// Data model for a contact item.
class ContactItem {
  final String name;
  final Color color;
  final String? id;

  const ContactItem({
    required this.name,
    required this.color,
    this.id,
  });
}

/// A horizontal scrollable list of contact avatars with an "Add" button.
///
/// Usage:
/// ```dart
/// FrequentContacts(
///   contacts: [ContactItem(name: 'Ana García', color: Colors.blue)],
///   onContactTap: (contact) => startTransfer(contact),
///   onAddTap: () => openAddContact(),
/// )
/// ```
class FrequentContacts extends StatelessWidget {
  final List<ContactItem> contacts;
  final void Function(ContactItem contact)? onContactTap;
  final VoidCallback? onAddTap;
  final double height;

  const FrequentContacts({
    super.key,
    required this.contacts,
    this.onContactTap,
    this.onAddTap,
    this.height = 90,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: contacts.length + 1,
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _AddButton(onTap: onAddTap);
          }

          final contact = contacts[index - 1];
          return ContactAvatar(
            name: contact.name,
            color: contact.color,
            onTap: onContactTap != null ? () => onContactTap!(contact) : null,
          );
        },
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _AddButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: ArgonColors.border.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(
                color: ArgonColors.border,
                width: 1.5,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
            child: const Icon(Icons.add_rounded, color: ArgonColors.muted, size: 24),
          ),
          const SizedBox(height: 8),
          const SizedBox(
            width: 68,
            child: Text(
              'Add',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: ArgonColors.muted),
            ),
          ),
        ],
      ),
    );
  }
}
