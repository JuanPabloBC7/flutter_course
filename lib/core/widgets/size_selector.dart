import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/l10n/app_localizations.dart';

/// Size selector widget with XS, S, M, L, XL options
class SizeSelector extends StatelessWidget {
  final String selectedSize;
  final List<String> sizes;
  final Function(String) onSizeSelected;

  const SizeSelector({
    super.key,
    required this.selectedSize,
    this.sizes = const ['XS', 'S', 'M', 'L', 'XL'],
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.sizeLabel,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: ArgonColors.text,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: List.generate(
            sizes.length,
            (index) {
              final size = sizes[index];
              final isSelected = selectedSize == size;

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index == sizes.length - 1 ? 0 : 8),
                  child: GestureDetector(
                    onTap: () => onSizeSelected(size),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: isSelected ? ArgonColors.primary : ArgonColors.white,
                        border: Border.all(
                          color: isSelected
                              ? ArgonColors.primary
                              : ArgonColors.border,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          size,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? ArgonColors.white : ArgonColors.text,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
