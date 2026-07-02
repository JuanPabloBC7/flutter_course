import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/providers/locale_provider.dart';
import 'package:flutter_course/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Reusable language selection bottom sheet.
///
/// Usage from any ConsumerWidget or ConsumerState:
/// ```dart
/// LanguageSheet.show(context, ref);
/// ```
class LanguageSheet {
  LanguageSheet._();

  static void show(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.read(localeProvider);

    showModalBottomSheet(
      context: context,
      backgroundColor: ArgonColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: ArgonColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.selectLanguage,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: ArgonColors.text),
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: ArgonColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text('EN', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: ArgonColors.primary)),
                    ),
                  ),
                  title: Text(l10n.languageEnglish, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: ArgonColors.text)),
                  trailing: currentLocale.languageCode == 'en'
                      ? const Icon(Icons.check_rounded, color: ArgonColors.primary, size: 20)
                      : null,
                  onTap: () {
                    ref.read(localeProvider.notifier).setLocale(const Locale('en', 'US'));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: ArgonColors.warning.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text('ES', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: ArgonColors.warning)),
                    ),
                  ),
                  title: Text(l10n.languageSpanish, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: ArgonColors.text)),
                  trailing: currentLocale.languageCode == 'es'
                      ? const Icon(Icons.check_rounded, color: ArgonColors.primary, size: 20)
                      : null,
                  onTap: () {
                    ref.read(localeProvider.notifier).setLocale(const Locale('es', 'ES'));
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
