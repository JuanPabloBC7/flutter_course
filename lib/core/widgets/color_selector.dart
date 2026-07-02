import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/l10n/app_localizations.dart';

/// Color selector widget with circular color options
class ColorSelector extends StatelessWidget {
  final String selectedColor;
  final List<Color> colors;
  final List<String> colorNames;
  final Function(String, Color) onColorSelected;

  const ColorSelector({
    super.key,
    required this.selectedColor,
    this.colors = const [
      Color(0xFF000000), // Black
      Color(0xFF808080), // Gray
      Color(0xFF5E72E4), // Blue (Primary)
      Color(0xFFD3D3D3), // Light Gray
    ],
    this.colorNames = const ['Black', 'Gray', 'Blue', 'Light Gray'],
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.colorLabel,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: ArgonColors.text,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: List.generate(
            colors.length,
            (index) {
              final color = colors[index];
              final colorHex = '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
              final isSelected = selectedColor == colorHex;

              return Padding(
                padding: EdgeInsets.only(right: index == colors.length - 1 ? 0 : 12),
                child: GestureDetector(
                  onTap: () => onColorSelected(colorHex, color),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? ArgonColors.primary : ArgonColors.border,
                        width: isSelected ? 3 : 1.5,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            color: ArgonColors.white,
                            size: 24,
                          )
                        : null,
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
