import 'package:flutter/material.dart';

/// Loading indicator size
enum LoadingSize {
  /// Extra small loading indicator
  extraSmall,
  
  /// Small loading indicator
  small,
  
  /// Medium loading indicator
  medium,
  
  /// Large loading indicator
  large,
  
  /// Extra large loading indicator
  extraLarge,
}

/// A reusable loading indicator with consistent styling.
///
/// This component provides a standardized way to show loading states
/// throughout the application.
class LoadingIndicator extends StatelessWidget {
  /// Creates a loading indicator.
  ///
  /// [size] controls the dimensions of the indicator.
  /// [color] overrides the default color.
  /// [strokeWidth] controls the thickness of the indicator.
  /// [value] makes the indicator determinate when provided.
  /// [text] displays a loading message below the indicator.
  const LoadingIndicator({
    super.key,
    this.size = LoadingSize.medium,
    this.color,
    this.strokeWidth,
    this.value,
    this.text,
  });

  /// Size of the loading indicator
  final LoadingSize size;
  
  /// Color of the loading indicator
  final Color? color;
  
  /// Stroke width of the loading indicator
  final double? strokeWidth;
  
  /// Progress value (0.0 to 1.0) for determinate progress
  final double? value;
  
  /// Optional loading text to display
  final String? text;
  
  /// Get the diameter based on size
  double _getDiameter() {
    switch (size) {
      case LoadingSize.extraSmall:
        return 16.0;
      case LoadingSize.small:
        return 24.0;
      case LoadingSize.medium:
        return 32.0;
      case LoadingSize.large:
        return 48.0;
      case LoadingSize.extraLarge:
        return 64.0;
    }
  }
  
  /// Get the stroke width based on size
  double _getStrokeWidth() {
    if (strokeWidth != null) return strokeWidth!;
    
    switch (size) {
      case LoadingSize.extraSmall:
        return 2.0;
      case LoadingSize.small:
        return 2.5;
      case LoadingSize.medium:
        return 3.0;
      case LoadingSize.large:
        return 4.0;
      case LoadingSize.extraLarge:
        return 5.0;
    }
  }
  
  /// Get the text style based on size
  TextStyle? _getTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    
    switch (size) {
      case LoadingSize.extraSmall:
      case LoadingSize.small:
        return theme.textTheme.bodySmall;
      case LoadingSize.medium:
        return theme.textTheme.bodyMedium;
      case LoadingSize.large:
      case LoadingSize.extraLarge:
        return theme.textTheme.bodyLarge;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final indicatorColor = color ?? theme.colorScheme.primary;
    final diameter = _getDiameter();
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: diameter,
          height: diameter,
          child: CircularProgressIndicator(
            value: value,
            strokeWidth: _getStrokeWidth(),
            valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
          ),
        ),
        if (text != null) ...[
          const SizedBox(height: 12),
          Text(
            text!,
            style: _getTextStyle(context),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
