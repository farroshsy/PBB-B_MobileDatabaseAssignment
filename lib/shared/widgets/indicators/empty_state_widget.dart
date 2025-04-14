import 'package:flutter/material.dart';

/// A reusable widget for displaying empty states with consistent styling.
///
/// This component provides a standardized way to show empty states
/// throughout the application, such as when a list has no items.
class EmptyStateWidget extends StatelessWidget {
  /// Creates an empty state widget.
  ///
  /// [message] is the message to display.
  /// [onAction] is an optional callback for a primary action.
  /// [actionLabel] is the label for the primary action button.
  /// [icon] overrides the default empty state icon.
  /// [iconSize] controls the size of the icon.
  /// [title] adds an optional title above the message.
  /// [alignment] controls the alignment of the content.
  /// [padding] customizes the padding around the content.
  /// [maxContentWidth] limits the maximum width of the content.
  /// [imagePath] displays an image instead of an icon.
  /// [imageWidth] controls the width of the image.
  const EmptyStateWidget({
    required this.message,
    super.key,
    this.onAction,
    this.actionLabel,
    this.icon,
    this.iconSize = 64.0,
    this.title,
    this.alignment = Alignment.center,
    this.padding = const EdgeInsets.all(16.0),
    this.maxContentWidth = 400.0,
    this.imagePath,
    this.imageWidth,
  }) : assert(
          (icon != null && imagePath == null) ||
          (icon == null && imagePath != null) ||
          (icon == null && imagePath == null),
          'Cannot provide both icon and imagePath',
        );

  /// The message to display
  final String message;
  
  /// Optional callback for primary action
  final VoidCallback? onAction;
  
  /// Label for the primary action button
  final String? actionLabel;
  
  /// Optional custom icon
  final IconData? icon;
  
  /// Size of the icon
  final double iconSize;
  
  /// Optional title text
  final String? title;
  
  /// Alignment of the content
  final Alignment alignment;
  
  /// Padding around the content
  final EdgeInsetsGeometry padding;
  
  /// Maximum width of the content
  final double maxContentWidth;
  
  /// Optional image path instead of an icon
  final String? imagePath;
  
  /// Width of the image if provided
  final double? imageWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    Widget content = Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: Padding(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon or image
              if (icon != null)
                Icon(
                  icon,
                  size: iconSize,
                  color: theme.colorScheme.primary.withAlpha((255 * 0.7).round()),
                )
              else if (imagePath != null)
                Image.asset(
                  imagePath!,
                  width: imageWidth ?? 120,
                )
              else
                Icon(
                  Icons.inbox_outlined,
                  size: iconSize,
                  color: theme.colorScheme.primary.withAlpha((255 * 0.7).round()),
                ),
              const SizedBox(height: 16),
              
              // Title if provided
              if (title != null) ...[
                Text(
                  title!,
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
              ],
              
              // Message
              Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withAlpha((255 * 0.8).round()),
                ),
                textAlign: TextAlign.center,
              ),
              
              // Action button if callback provided
              if (onAction != null && actionLabel != null) ...[
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onAction,
                  child: Text(actionLabel!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
    
    // Apply alignment if it's not center
    if (alignment != Alignment.center) {
      content = Align(
        alignment: alignment,
        child: content,
      );
    }
    
    return content;
  }
}
