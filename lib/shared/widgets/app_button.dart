import 'package:flutter/material.dart';

/// Button types for [AppButton]
enum AppButtonType {
  /// Primary button with filled background
  primary,
  
  /// Secondary button with outlined style
  secondary,
  
  /// Text-only button
  text
}

/// A customizable button component for the application
class AppButton extends StatelessWidget {
  /// Button text
  final String text;
  
  /// Callback when button is pressed
  final VoidCallback? onPressed;
  
  /// Button type
  final AppButtonType type;
  
  /// Icon to display before text (optional)
  final IconData? icon;
  
  /// Whether the button should expand to fill width
  final bool isFullWidth;
  
  /// Whether the button is in a loading state
  final bool isLoading;
  
  /// Custom button height
  final double? height;
  
  /// Custom border radius
  final double? borderRadius;

  /// Creates a new [AppButton]
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.icon,
    this.isFullWidth = false,
    this.isLoading = false,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    // Different button based on type
    switch (type) {
      case AppButtonType.primary:
        return _buildElevatedButton(context);
      case AppButtonType.secondary:
        return _buildOutlinedButton(context);
      case AppButtonType.text:
        return _buildTextButton(context);
    }
  }

  /// Build an elevated button
  Widget _buildElevatedButton(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
        ),
        child: _buildButtonContent(context),
      ),
    );
  }

  /// Build an outlined button
  Widget _buildOutlinedButton(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height ?? 48,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
        ),
        child: _buildButtonContent(context),
      ),
    );
  }

  /// Build a text button
  Widget _buildTextButton(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height ?? 48,
      child: TextButton(
        onPressed: isLoading ? null : onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
        ),
        child: _buildButtonContent(context),
      ),
    );
  }

  /// Build the content of the button (text, icon, loading indicator)
  Widget _buildButtonContent(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(text),
        ],
      );
    }

    return Text(text);
  }
}
