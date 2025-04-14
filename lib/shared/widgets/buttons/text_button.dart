import 'package:flutter/material.dart';
import 'button_size.dart';
import 'button_type.dart';
import 'custom_button.dart';

/// A text button with consistent styling.
///
/// Use this for tertiary actions or in-content links.
class AppTextButton extends StatelessWidget {
  /// Creates a text button with the app's text button styling.
  /// 
  /// [text] is the button label.
  /// [onPressed] is called when the button is tapped.
  /// [icon] is an optional leading icon.
  /// [trailingIcon] is an optional trailing icon.
  /// [fullWidth] makes the button expand to parent width.
  /// [size] defines the button dimensions.
  /// [isDisabled] disables the button when true.
  /// [isLoading] shows a loading indicator when true.
  /// [foregroundColor] overrides the default text/icon color.
  /// [borderRadius] customizes the button's corner radius.
  const AppTextButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.icon,
    this.trailingIcon,
    this.fullWidth = false,
    this.size = ButtonSize.medium,
    this.isDisabled = false,
    this.isLoading = false,
    this.foregroundColor,
    this.borderRadius,
  });

  /// Button text label
  final String text;
  
  /// Optional leading icon
  final IconData? icon;
  
  /// Optional trailing icon
  final IconData? trailingIcon;
  
  /// Whether to use the full available width
  final bool fullWidth;
  
  /// Button size
  final ButtonSize size;
  
  /// Button click handler
  final VoidCallback onPressed;
  
  /// Whether the button is disabled
  final bool isDisabled;
  
  /// Whether to show a loading indicator
  final bool isLoading;
  
  /// Custom text color
  final Color? foregroundColor;
  
  /// Custom border radius
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      type: ButtonType.tertiary,
      icon: icon,
      trailingIcon: trailingIcon,
      fullWidth: fullWidth,
      size: size,
      onPressed: onPressed,
      isDisabled: isDisabled,
      isLoading: isLoading,
      foregroundColor: foregroundColor,
      borderRadius: borderRadius,
      elevation: 0,
    );
  }
}
