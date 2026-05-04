import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';

/// A form-aware input widget that supports validation via [TextFormField].
///
/// Use this inside a [Form] widget to get automatic validation
/// with [FormState.validate()].
class FormInput extends StatelessWidget {
  final String? placeholder;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final AutovalidateMode autovalidateMode;

  const FormInput({
    super.key,
    this.placeholder,
    this.label,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.onChanged,
    this.autofocus = false,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: ArgonColors.primary,
      onTap: onTap,
      onChanged: onChanged,
      controller: controller,
      autofocus: autofocus,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autovalidateMode: autovalidateMode,
      validator: validator,
      style: const TextStyle(
        height: 1.2,
        fontSize: 14.0,
        color: ArgonColors.initial,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: ArgonColors.white,
        hintText: placeholder,
        labelText: label,
        hintStyle: const TextStyle(color: ArgonColors.muted, fontSize: 14),
        labelStyle: const TextStyle(color: ArgonColors.muted, fontSize: 14),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ArgonColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ArgonColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ArgonColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ArgonColors.error, width: 1.5),
        ),
        errorStyle: const TextStyle(
          fontSize: 12,
          color: ArgonColors.error,
          fontWeight: FontWeight.w500,
        ),
        errorMaxLines: 2,
      ),
    );
  }
}
