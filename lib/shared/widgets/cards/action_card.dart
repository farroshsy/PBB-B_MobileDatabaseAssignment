import 'package:flutter/material.dart';
import 'app_card.dart';

/// Enum to define standard card elevation levels.
enum CardElevation {
  /// No elevation.
  none,
  /// Low elevation (small shadow).
  low,
  /// Medium elevation (moderate shadow).
  medium,
  /// High elevation (large shadow).
  high,
}

/// A card with a title, content, and action buttons.
///
/// Use this for cards that require user interaction.
class ActionCard extends StatelessWidget {
  /// Creates an action card with title, content, and actions.
  ///
  /// [title] is the card title.
  /// [content] is the main content of the card.
  /// [actions] are the action buttons shown at the bottom.
  /// [padding] defines the internal padding.
  /// [margin] defines the external spacing.
  /// [elevation] controls the shadow intensity.
  /// [borderRadius] customizes the corner radius.
  /// [color] overrides the default background color.
  /// [hasBorder] adds a border when true.
  /// [borderColor] defines the border color when [hasBorder] is true.
  /// [titleTextStyle] customizes the title text style.
  /// [contentPadding] defines the padding between title, content, and actions.
  const ActionCard({
    required this.title,
    required this.content,
    this.actions = const [],
    super.key,
    this.padding,
    this.margin = const EdgeInsets.only(bottom: 16.0),
    this.elevation = CardElevation.low,
    this.borderRadius,
    this.color,
    this.hasBorder = false,
    this.borderColor,
    this.titleTextStyle,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 12.0),
    this.headerLeadingIcon,
    this.headerTrailingWidget,
  });

  /// Card title
  final String title;
  
  /// Card content
  final Widget content;
  
  /// Action buttons
  final List<Widget> actions;
  
  /// Card padding
  final EdgeInsetsGeometry? padding;
  
  /// Card margin
  final EdgeInsetsGeometry? margin;
  
  /// Card elevation level
  final CardElevation elevation;
  
  /// Card border radius
  final BorderRadius? borderRadius;
  
  /// Card background color
  final Color? color;
  
  /// Whether to add a border
  final bool hasBorder;
  
  /// Border color
  final Color? borderColor;
  
  /// Custom title text style
  final TextStyle? titleTextStyle;
  
  /// Padding between title, content, and actions
  final EdgeInsetsGeometry contentPadding;
  
  /// Optional icon to display before the title
  final IconData? headerLeadingIcon;
  
  /// Optional widget to display after the title
  final Widget? headerTrailingWidget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Map CardElevation enum to double values for AppCard
    double getElevationValue(CardElevation level) {
      switch (level) {
        case CardElevation.none: return 0.0;
        case CardElevation.low: return 2.0;
        case CardElevation.medium: return 4.0;
        case CardElevation.high: return 8.0;
        default: return 2.0; // Default to low
      }
    }

    final titleStyle = titleTextStyle ?? theme.textTheme.titleMedium;
    
    // Use default border radius from AppCard if none provided, extract the radius value.
    // AppCard default is 12.0. Using a slightly different default here for demo.
    final effectiveBorderRadiusValue = borderRadius?.topLeft.x ?? 10.0; 

    return AppCard(
      padding: padding ?? const EdgeInsets.all(16.0),
      margin: margin ?? const EdgeInsets.only(bottom: 16.0),
      elevation: getElevationValue(elevation),
      borderRadius: effectiveBorderRadiusValue,
      color: color,
      border: hasBorder 
        ? BorderSide(color: borderColor ?? theme.dividerColor) 
        : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title row
          Row(
            children: [
              if (headerLeadingIcon != null) ...[
                Icon(headerLeadingIcon, size: 20),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  title,
                  style: titleStyle,
                ),
              ),
              if (headerTrailingWidget != null)
                headerTrailingWidget!,
            ],
          ),
          
          // Content with padding
          Padding(
            padding: contentPadding,
            child: content,
          ),
          
          // Actions if any
          if (actions.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions.map((action) {
                final index = actions.indexOf(action);
                return Padding(
                  padding: EdgeInsets.only(
                    left: index > 0 ? 8.0 : 0.0,
                  ),
                  child: action,
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
