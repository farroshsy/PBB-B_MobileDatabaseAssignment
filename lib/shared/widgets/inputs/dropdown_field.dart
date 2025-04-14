import 'package:flutter/material.dart';

/// A reusable dropdown field with consistent styling.
///
/// This component provides a standardized way to present a dropdown selection
/// throughout the application.
class DropdownField<T> extends StatelessWidget {
  /// Creates a dropdown field.
  ///
  /// [value] is the currently selected value.
  /// [items] is the list of items to choose from.
  /// [onChanged] is called when the selection changes.
  /// [itemBuilder] builds the dropdown items.
  /// [label] is the field label.
  /// [hint] is an optional hint text.
  /// [prefixIcon] adds an icon at the start of the field.
  /// [isRequired] adds a required indicator when true.
  /// [enabled] enables/disables the field.
  /// [errorText] displays an error message.
  /// [helperText] displays helper text below the field.
  /// [fillColor] sets the background color of the field.
  /// [validator] provides validation logic.
  /// [borderRadius] customizes the field's corner radius.
  const DropdownField({
    required this.items,
    required this.onChanged,
    required this.itemBuilder,
    this.value,
    this.label,
    this.hint,
    this.prefixIcon,
    this.isRequired = false,
    this.enabled = true,
    this.errorText,
    this.helperText,
    this.fillColor,
    this.validator,
    this.borderRadius,
    super.key,
  });

  /// Currently selected value
  final T? value;
  
  /// List of items to choose from
  final List<T> items;
  
  /// Called when selection changes
  final ValueChanged<T?>? onChanged;
  
  /// Builds dropdown items
  final String Function(T) itemBuilder;
  
  /// Field label
  final String? label;
  
  /// Hint text
  final String? hint;
  
  /// Icon at the start of the field
  final Widget? prefixIcon;
  
  /// Whether the field is required
  final bool isRequired;
  
  /// Whether the field is enabled
  final bool enabled;
  
  /// Error message text
  final String? errorText;
  
  /// Helper text
  final String? helperText;
  
  /// Background color
  final Color? fillColor;
  
  /// Validation function
  final String? Function(T?)? validator;
  
  /// Corner radius
  final BorderRadius? borderRadius;

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
    
    // Create dropdown items
    final dropdownItems = items.map<DropdownMenuItem<T>>((T item) {
      return DropdownMenuItem<T>(
        value: item,
        child: Text(itemBuilder(item)),
      );
    }).toList();
    
    return DropdownButtonFormField<T>(
      value: value,
      items: dropdownItems,
      onChanged: enabled ? onChanged : null,
      decoration: InputDecoration(
        labelText: label,
        label: labelWidget,
        hintText: hint,
        prefixIcon: prefixIcon,
        errorText: errorText,
        helperText: helperText,
        filled: fillColor != null,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
      validator: validator,
      isExpanded: true,
      borderRadius: borderRadius,
      icon: const Icon(Icons.arrow_drop_down),
    );
  }
}
