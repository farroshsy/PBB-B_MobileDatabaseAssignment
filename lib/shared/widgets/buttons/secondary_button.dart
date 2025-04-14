import 'package:flutter/material.dart';
import 'button_size.dart'; // Import shared ButtonSize enum

/// Secondary button for secondary actions throughout the app
class SecondaryButton extends StatelessWidget {
  /// Creates a secondary button
  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.iconPosition = IconPosition.left,
    this.size = ButtonSize.medium,
  });

  /// Callback when button is pressed
  final VoidCallback? onPressed;
  
  /// Button text
  final String text;
  
  /// Whether the button is in loading state
  final bool isLoading;
  
  /// Whether the button should take full width
  final bool isFullWidth;
  
  /// Optional icon to display
  final IconData? icon;
  
  /// Icon position (left or right)
  final IconPosition iconPosition;
  
  /// Button size
  final ButtonSize size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Size-based properties
    final height = _getHeight();
    final padding = _getPadding();
    final textStyle = _getTextStyle(theme);
    
    // Create button
    final button = OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        padding: padding,
        minimumSize: Size(0, height),
        side: BorderSide(
          color: onPressed == null 
            ? theme.colorScheme.outline.withAlpha((255 * 0.5).round())
            : theme.colorScheme.primary,
          width: 1.5,
        ),
        backgroundColor: Colors.transparent,
      ),
      child: _buildContent(context, textStyle),
    );
    
    // Apply full width if needed
    return isFullWidth 
      ? SizedBox(width: double.infinity, child: button)
      : button;
  }
  
  Widget _buildContent(BuildContext context, TextStyle textStyle) {
    if (isLoading) {
      return _buildLoadingIndicator(context);
    }
    
    if (icon == null) {
      return Text(text, style: textStyle);
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: iconPosition == IconPosition.left
        ? _buildLeftIconContent(context, textStyle)
        : _buildRightIconContent(context, textStyle),
    );
  }
  
  List<Widget> _buildLeftIconContent(BuildContext context, TextStyle textStyle) {
    return [
      Icon(icon, size: _getIconSize(), color: Theme.of(context).colorScheme.primary),
      SizedBox(width: _getIconSpacing()),
      Text(text, style: textStyle),
    ];
  }
  
  List<Widget> _buildRightIconContent(BuildContext context, TextStyle textStyle) {
    return [
      Text(text, style: textStyle),
      SizedBox(width: _getIconSpacing()),
      Icon(icon, size: _getIconSize(), color: Theme.of(context).colorScheme.primary),
    ];
  }
  
  Widget _buildLoadingIndicator(BuildContext context) {
    final theme = Theme.of(context);
    final size = _getLoadingSize();
    
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        color: theme.colorScheme.primary,
      ),
    );
  }
  
  double _getHeight() {
    switch (size) {
      case ButtonSize.small:
        return 36.0;
      case ButtonSize.medium:
        return 44.0;
      case ButtonSize.large:
        return 52.0;
      default:
        return 44.0;
    }
  }
  
  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12.0);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16.0);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24.0);
      default:
        return const EdgeInsets.symmetric(horizontal: 16.0);
    }
  }
  
  TextStyle _getTextStyle(ThemeData theme) {
    final baseStyle = theme.textTheme.labelLarge!.copyWith(
      color: theme.colorScheme.primary,
    );
    
    switch (size) {
      case ButtonSize.small:
        return baseStyle.copyWith(fontSize: 13.0);
      case ButtonSize.medium:
        return baseStyle.copyWith(fontSize: 14.0);
      case ButtonSize.large:
        return baseStyle.copyWith(fontSize: 16.0);
      default:
        return baseStyle.copyWith(fontSize: 14.0);
    }
  }
  
  double _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return 16.0;
      case ButtonSize.medium:
        return 18.0;
      case ButtonSize.large:
        return 20.0;
      default:
        return 18.0;
    }
  }
  
  double _getIconSpacing() {
    switch (size) {
      case ButtonSize.small:
        return 6.0;
      case ButtonSize.medium:
        return 8.0;
      case ButtonSize.large:
        return 10.0;
      default:
        return 8.0;
    }
  }
  
  double _getLoadingSize() {
    switch (size) {
      case ButtonSize.small:
        return 16.0;
      case ButtonSize.medium:
        return 20.0;
      case ButtonSize.large:
        return 24.0;
      default:
        return 20.0;
    }
  }
}

/// Icon position options
enum IconPosition {
  /// Icon on the left side of text
  left,
  
  /// Icon on the right side of text
  right,
}
