import 'package:flutter/material.dart';

/// Standard card with consistent styling
class AppCard extends StatelessWidget {
  /// Creates an app card
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.color,
    this.elevation = 2,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.only(bottom: 16),
    this.borderRadius = 12,
    this.border,
  });

  /// Child widget
  final Widget child;
  
  /// Optional tap callback
  final VoidCallback? onTap;
  
  /// Card color
  final Color? color;
  
  /// Card elevation
  final double elevation;
  
  /// Inside padding
  final EdgeInsetsGeometry padding;
  
  /// Outside margin
  final EdgeInsetsGeometry margin;
  
  /// Corner radius
  final double borderRadius;
  
  /// Optional border
  final BorderSide? border;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final card = Card(
      elevation: elevation,
      margin: margin,
      color: color ?? theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: border ?? BorderSide.none,
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
    
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: card,
      );
    }
    
    return card;
  }
}
