import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Standard text input field with consistent styling
class TextInput extends StatelessWidget {
  /// Creates a text input field
  const TextInput({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.autofocus = false,
  });

  /// Text editing controller
  final TextEditingController controller;
  
  /// Optional label text
  final String? labelText;
  
  /// Optional hint text
  final String? hintText;
  
  /// Optional prefix icon
  final Widget? prefixIcon;
  
  /// Optional suffix icon
  final Widget? suffixIcon;
  
  /// Whether to hide text input
  final bool obscureText;
  
  /// Keyboard type
  final TextInputType? keyboardType;
  
  /// Text capitalization behavior
  final TextCapitalization textCapitalization;
  
  /// Action to take when submitting
  final TextInputAction textInputAction;
  
  /// Optional validator function
  final String? Function(String?)? validator;
  
  /// Optional callback when text changes
  final void Function(String)? onChanged;
  
  /// Optional callback when field is submitted
  final void Function(String)? onFieldSubmitted;
  
  /// Whether input is enabled
  final bool enabled;
  
  /// Whether input is read-only
  final bool readOnly;
  
  /// Maximum number of lines
  final int? maxLines;
  
  /// Minimum number of lines
  final int? minLines;
  
  /// Maximum text length
  final int? maxLength;
  
  /// Input formatters for restricting input
  final List<TextInputFormatter>? inputFormatters;
  
  /// Whether to focus automatically
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: theme.colorScheme.outline.withAlpha((255 * 0.5).round()),
      ),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: theme.colorScheme.primary,
        width: 2,
      ),
    );

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
      readOnly: readOnly,
      maxLines: obscureText ? 1 : maxLines,
      minLines: minLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      autofocus: autofocus,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: border,
        enabledBorder: border,
        focusedBorder: focusedBorder,
        errorBorder: border.copyWith(
          borderSide: BorderSide(
            color: theme.colorScheme.error,
          ),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        filled: true,
        fillColor: enabled
            ? theme.inputDecorationTheme.fillColor
            : theme.disabledColor.withAlpha((255 * 0.1).round()),
      ),
    );
  }
}
