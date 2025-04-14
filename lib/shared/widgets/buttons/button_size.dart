/// Button size enum to standardize dimensions
enum ButtonSize {
  /// Extra small button
  extraSmall,
  
  /// Small button
  small,
  
  /// Medium button (default)
  medium,
  
  /// Large button
  large,
  
  /// Extra large button
  extraLarge,
}

/// Extension to provide dimension values for button sizes
extension ButtonSizeExtension on ButtonSize {
  /// Get horizontal padding based on button size
  double get horizontalPadding {
    switch (this) {
      case ButtonSize.extraSmall:
        return 8.0;
      case ButtonSize.small:
        return 12.0;
      case ButtonSize.medium:
        return 16.0;
      case ButtonSize.large:
        return 20.0;
      case ButtonSize.extraLarge:
        return 24.0;
    }
  }
  
  /// Get vertical padding based on button size
  double get verticalPadding {
    switch (this) {
      case ButtonSize.extraSmall:
        return 4.0;
      case ButtonSize.small:
        return 8.0;
      case ButtonSize.medium:
        return 12.0;
      case ButtonSize.large:
        return 16.0;
      case ButtonSize.extraLarge:
        return 20.0;
    }
  }
  
  /// Get icon size based on button size
  double get iconSize {
    switch (this) {
      case ButtonSize.extraSmall:
        return 16.0;
      case ButtonSize.small:
        return 18.0;
      case ButtonSize.medium:
        return 20.0;
      case ButtonSize.large:
        return 22.0;
      case ButtonSize.extraLarge:
        return 24.0;
    }
  }
  
  /// Get text style scale factor based on button size
  double get textScaleFactor {
    switch (this) {
      case ButtonSize.extraSmall:
        return 0.8;
      case ButtonSize.small:
        return 0.9;
      case ButtonSize.medium:
        return 1.0;
      case ButtonSize.large:
        return 1.1;
      case ButtonSize.extraLarge:
        return 1.2;
    }
  }
}
