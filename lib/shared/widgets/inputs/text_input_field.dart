import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A reusable text input field with consistent styling.
///
/// This component provides a standardized way to collect text input
/// throughout the application.
class TextInputField extends StatelessWidget {
  /// Creates a text input field.
  ///
  /// [controller] is the controller for the text field.
  /// [label] is the field label.
  /// [hint] is an optional hint text.
  /// [prefixIcon] adds an icon at the start of the field.
  /// [suffixIcon] adds an icon at the end of the field.
  /// [onChanged] is called when the text changes.
  /// [onSubmitted] is called when the user submits the field.
  /// [validator] provides validation logic.
  /// [isRequired] adds a required indicator when true.
  /// [keyboardType] specifies the keyboard type.
  /// [maxLength] limits the maximum character count.
  /// [maxLines] controls the number of visible lines.
  /// [minLines] controls the minimum number of visible lines.
  /// [autofocus] focuses the field automatically when true.
  /// [readOnly] makes the field read-only when true.
  /// [obscureText] hides the text when true (for passwords).
  /// [enabled] enables/disables the field.
  /// [textCapitalization] controls text capitalization.
  /// [inputFormatters] provides input formatters.
  /// [errorText] displays an error message.
  /// [helperText] displays helper text below the field.
  /// [fillColor] sets the background color of the field.
  /// [borderRadius] customizes the field's corner radius.
  /// [onTap] is called when the field is tapped.
  /// [autofillHints] provides autofill hints.
  /// [contentPadding] customizes the internal padding.
  const TextInputField({
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.isRequired = false,
    this.keyboardType,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.autofocus = false,
    this.readOnly = false,
    this.obscureText = false,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.errorText,
    this.helperText,
    this.fillColor,
    this.borderRadius,
    this.onTap,
    this.autofillHints,
    this.contentPadding,
    super.key,
  });

  /// Text editing controller
  final TextEditingController? controller;
  
  /// Field label
  final String? label;
  
  /// Hint text
  final String? hint;
  
  /// Icon at the start of the field
  final Widget? prefixIcon;
  
  /// Icon at the end of the field
  final Widget? suffixIcon;
  
  /// Called when text changes
  final ValueChanged<String>? onChanged;
  
  /// Called when field is submitted
  final ValueChanged<String>? onSubmitted;
  
  /// Validation function
  final String? Function(String?)? validator;
  
  /// Whether the field is required
  final bool isRequired;
  
  /// Keyboard type
  final TextInputType? keyboardType;
  
  /// Maximum character count
  final int? maxLength;
  
  /// Number of visible lines
  final int? maxLines;
  
  /// Minimum number of visible lines
  final int? minLines;
  
  /// Whether to focus automatically
  final bool autofocus;
  
  /// Whether the field is read-only
  final bool readOnly;
  
  /// Whether to hide the text (for passwords)
  final bool obscureText;
  
  /// Whether the field is enabled
  final bool enabled;
  
  /// Text capitalization behavior
  final TextCapitalization textCapitalization;
  
  /// Input formatters
  final List<TextInputFormatter>? inputFormatters;
  
  /// Error message text
  final String? errorText;
  
  /// Helper text
  final String? helperText;
  
  /// Background color
  final Color? fillColor;
  
  /// Corner radius
  final BorderRadius? borderRadius;
  
  /// Called when field is tapped
  final VoidCallback? onTap;
  
  /// Autofill hints
  final Iterable<String>? autofillHints;
  
  /// Internal padding
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Build the label with required indicator if needed
    Widget? labelWidget;
    if (label != null) {
      labelWidget = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label!),
          if (isRequired) ...[
            const SizedBox(width: 4),
            Text(
              '*',
              style: TextStyle(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      );
    }
    
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        label: labelWidget,
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorText: errorText,
        helperText: helperText,
        filled: fillColor != null,
        fillColor: fillColor,
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      maxLength: maxLength,
      maxLines: obscureText ? 1 : maxLines,
      minLines: minLines,
      autofocus: autofocus,
      readOnly: readOnly,
      obscureText: obscureText,
      enabled: enabled,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      onTap: onTap,
      autofillHints: autofillHints,
    );
  }
}
