import 'package:flutter/material.dart';

/// A reusable widget for displaying errors with consistent styling.
///
/// This component provides a standardized way to show error states
/// throughout the application.
class AppErrorWidget extends StatelessWidget {
  /// Creates an error widget.
  ///
  /// [message] is the error message to display.
  /// [onRetry] is an optional callback for retry functionality.
  /// [icon] overrides the default error icon.
  /// [iconSize] controls the size of the icon.
  /// [title] adds an optional title above the message.
  /// [alignment] controls the alignment of the error.
  /// [padding] customizes the padding around the error.
  /// [maxContentWidth] limits the maximum width of the content.
  const AppErrorWidget({
    required this.message,
    super.key,
    this.onRetry,
    this.icon,
    this.iconSize = 48.0,
    this.title,
    this.alignment = Alignment.center,
    this.padding = const EdgeInsets.all(16.0),
    this.maxContentWidth = 400.0,
  });

  /// The error message to display
  final String message;
  
  /// Optional callback for retry action
  final VoidCallback? onRetry;
  
  /// Optional custom icon
  final IconData? icon;
  
  /// Size of the icon
  final double iconSize;
  
  /// Optional title text
  final String? title;
  
  /// Alignment of the error content
  final Alignment alignment;
  
  /// Padding around the error content
  final EdgeInsetsGeometry padding;
  
  /// Maximum width of the content
  final double maxContentWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorColor = theme.colorScheme.error;
    
    Widget content = Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: Padding(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Error icon
              Icon(
                icon ?? Icons.error_outline,
                size: iconSize,
                color: errorColor,
              ),
              const SizedBox(height: 16),
              
              // Error title if provided
              if (title != null) ...[
                Text(
                  title!,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
              ],
              
              // Error message
              Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withAlpha((255 * 0.8).round()),
                ),
                textAlign: TextAlign.center,
              ),
              
              // Retry button if callback provided
              if (onRetry != null) ...[
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
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
