import 'package:flutter/material.dart';
import 'loading_indicator.dart';

/// A loading overlay that blocks user interaction while displaying a loading indicator.
///
/// This component is useful for showing loading states during asynchronous operations
/// while preventing user interaction with the underlying UI.
class LoadingOverlay extends StatelessWidget {
  /// Creates a loading overlay.
  ///
  /// [isLoading] controls whether the overlay is visible.
  /// [child] is the widget to display beneath the overlay.
  /// [text] is an optional message to display with the indicator.
  /// [color] overrides the default indicator color.
  /// [backgroundColor] overrides the default overlay background color.
  /// [loadingSize] controls the size of the loading indicator.
  /// [dismissible] allows tapping outside to dismiss when true.
  /// [onDismiss] callback when the overlay is dismissed.
  const LoadingOverlay({
    required this.isLoading,
    required this.child,
    super.key,
    this.text,
    this.color,
    this.backgroundColor,
    this.loadingSize = LoadingSize.medium,
    this.dismissible = false,
    this.onDismiss,
  });

  /// Whether to show the loading overlay
  final bool isLoading;
  
  /// The widget to display beneath the overlay
  final Widget child;
  
  /// Optional text to display with the loading indicator
  final String? text;
  
  /// Color of the loading indicator
  final Color? color;
  
  /// Background color of the overlay
  final Color? backgroundColor;
  
  /// Size of the loading indicator
  final LoadingSize loadingSize;
  
  /// Whether the overlay can be dismissed by tapping
  final bool dismissible;
  
  /// Callback when the overlay is dismissed
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The main content
        child,
        
        // The loading overlay
        if (isLoading)
          Positioned.fill(
            child: GestureDetector(
              onTap: dismissible ? onDismiss : null,
              child: Container(
                color: backgroundColor ?? Colors.black.withAlpha((255 * 0.5).round()),
                child: Center(
                  child: LoadingIndicator(
                    size: loadingSize,
                    color: color,
                    text: text,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
