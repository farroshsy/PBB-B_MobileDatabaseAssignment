import 'package:flutter/material.dart';
import 'styled_text.dart';

/// A reusable section title widget with consistent styling.
///
/// This component provides a standardized way to display section titles
/// throughout the application.
class SectionTitle extends StatelessWidget {
  /// Creates a section title.
  ///
  /// [title] is the title text.
  /// [subtitle] is an optional subtitle text.
  /// [action] is an optional action button.
  /// [icon] is an optional icon to display.
  /// [divider] adds a divider below the title when true.
  /// [padding] customizes the padding.
  /// [align] controls text alignment.
  const SectionTitle({
    required this.title,
    super.key,
    this.subtitle,
    this.action,
    this.icon,
    this.divider = false,
    this.padding,
    this.align = CrossAxisAlignment.start,
  });

  /// The title text
  final String title;
  
  /// Optional subtitle text
  final String? subtitle;
  
  /// Optional action button
  final Widget? action;
  
  /// Optional icon
  final IconData? icon;
  
  /// Whether to add a divider
  final bool divider;
  
  /// Custom padding
  final EdgeInsetsGeometry? padding;
  
  /// Content alignment
  final CrossAxisAlignment align;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              // Icon if provided
              if (icon != null) ...[
                Icon(
                  icon, 
                  size: 20, 
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
              ],
              
              // Title and subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: align,
                  children: [
                    StyledText(
                      title,
                      variant: TextVariant.titleMedium,
                      weight: FontWeight.bold,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      StyledText(
                        subtitle!,
                        variant: TextVariant.bodySmall,
                        isMuted: true,
                      ),
                    ],
                  ],
                ),
              ),
              
              // Action if provided
              if (action != null)
                action!,
            ],
          ),
        ),
        
        // Divider if requested
        if (divider)
          const Divider(height: 1),
      ],
    );
  }
}
