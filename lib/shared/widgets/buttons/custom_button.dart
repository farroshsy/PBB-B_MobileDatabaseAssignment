import 'package:flutter/material.dart';
import 'button_size.dart';
import 'button_type.dart';

/// A customizable button that serves as the foundation for all button variants.
///
/// This button provides consistent styling and behavior for all button types
/// in the application.
class CustomButton extends StatelessWidget {
  /// Creates a custom button with flexible configuration options.
  ///
  /// [text] is the button label.
  /// [type] defines the visual style of the button.
  /// [size] controls the dimensions of the button.
  /// [onPressed] is called when the button is tapped.
  /// [icon] is an optional leading icon.
  /// [trailingIcon] is an optional trailing icon.
  /// [fullWidth] makes the button expand to parent width.
  /// [isDisabled] disables the button when true.
  /// [isLoading] shows a loading indicator when true.
  /// [backgroundColor] overrides the default background color.
  /// [foregroundColor] overrides the default text/icon color.
  /// [borderRadius] customizes the button's corner radius.
  /// [elevation] sets the button's shadow elevation.
  const CustomButton({
    required this.text,
    required this.onPressed,
    required this.type,
    super.key,
    this.size = ButtonSize.medium,
    this.icon,
    this.trailingIcon,
    this.fullWidth = false,
    this.isDisabled = false,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.elevation,
  });

  /// Button text label
  final String text;

  /// Button type that defines its visual style
  final ButtonType type;

  /// Button size that defines its dimensions
  final ButtonSize size;

  /// Button click handler
  final VoidCallback onPressed;

  /// Optional leading icon
  final IconData? icon;

  /// Optional trailing icon
  final IconData? trailingIcon;

  /// Whether to use the full available width
  final bool fullWidth;

  /// Whether the button is disabled
  final bool isDisabled;

  /// Whether to show a loading indicator
  final bool isLoading;

  /// Custom background color
  final Color? backgroundColor;

  /// Custom text color
  final Color? foregroundColor;

  /// Custom border radius
  final BorderRadius? borderRadius;

  /// Custom elevation
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Determine colors based on button type
    Color defaultBgColor;
    Color defaultFgColor;
    
    switch (type) {
      case ButtonType.primary:
        defaultBgColor = theme.colorScheme.primary;
        defaultFgColor = theme.colorScheme.onPrimary;
        break;
      case ButtonType.secondary:
        defaultBgColor = theme.colorScheme.secondary;
        defaultFgColor = theme.colorScheme.onSecondary;
        break;
      case ButtonType.tertiary:
        defaultBgColor = Colors.transparent;
        defaultFgColor = theme.colorScheme.primary;
        break;
      case ButtonType.destructive:
        defaultBgColor = theme.colorScheme.error;
        defaultFgColor = theme.colorScheme.onError;
        break;
      case ButtonType.success:
        defaultBgColor = Colors.green;
        defaultFgColor = Colors.white;
        break;
      case ButtonType.warning:
        defaultBgColor = Colors.orange;
        defaultFgColor = Colors.white;
        break;
      case ButtonType.info:
        defaultBgColor = Colors.blue;
        defaultFgColor = Colors.white;
        break;
    }
    
    // Apply custom colors if provided
    final bgColor = backgroundColor ?? defaultBgColor;
    final fgColor = foregroundColor ?? defaultFgColor;
    
    // Determine padding based on size
    final buttonPadding = EdgeInsets.symmetric(
      horizontal: size.horizontalPadding,
      vertical: size.verticalPadding,
    );
    
    // Determine border radius
    final buttonBorderRadius = borderRadius ?? BorderRadius.circular(8.0);
    
    // Determine elevation
    final buttonElevation = elevation ?? (type == ButtonType.tertiary ? 0.0 : 2.0);
    
    // Build button style
    final buttonStyle = ElevatedButton.styleFrom(
      elevation: buttonElevation,
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      padding: buttonPadding,
      shape: RoundedRectangleBorder(borderRadius: buttonBorderRadius),
      disabledBackgroundColor: bgColor.withAlpha((255 * 0.6).round()),
      disabledForegroundColor: fgColor.withAlpha((255 * 0.6).round()),
      minimumSize: const Size(0, 0),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
    
    // Build button content
    Widget buttonContent;
    
    if (isLoading) {
      // Show loading indicator
      buttonContent = SizedBox(
        height: size.iconSize,
        width: size.iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(fgColor),
        ),
      );
    } else {
      // Build row with icon and text
      final List<Widget> rowChildren = [];
      
      // Add leading icon if provided
      if (icon != null) {
        rowChildren.add(Icon(icon, size: size.iconSize));
        rowChildren.add(SizedBox(width: size.horizontalPadding / 2));
      }
      
      // Add text
      rowChildren.add(
        Text(
          text,
          textScaler: TextScaler.linear(size.textScaleFactor),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
      
      // Add trailing icon if provided
      if (trailingIcon != null) {
        rowChildren.add(SizedBox(width: size.horizontalPadding / 2));
        rowChildren.add(Icon(trailingIcon, size: size.iconSize));
      }
      
      buttonContent = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: rowChildren,
      );
    }
    
    // Build the final button
    Widget button = ElevatedButton(
      style: buttonStyle,
      onPressed: (isDisabled || isLoading) ? null : onPressed,
      child: buttonContent,
    );
    
    // Apply full width if requested
    if (fullWidth) {
      button = SizedBox(
        width: double.infinity,
        child: button,
      );
    }
    
    return button;
  }
}
