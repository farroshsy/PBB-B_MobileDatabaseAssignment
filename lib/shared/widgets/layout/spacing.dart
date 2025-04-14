import 'package:flutter/material.dart';

/// Constants for standard spacing values
class Spacing {
  // Private constructor to prevent instantiation
  Spacing._();

  /// Extra extra small spacing (2px)
  static const double xxs = 2.0;
  
  /// Extra small spacing (4px)
  static const double xs = 4.0;
  
  /// Small spacing (8px)
  static const double sm = 8.0;
  
  /// Medium spacing (16px)
  static const double md = 16.0;
  
  /// Large spacing (24px)
  static const double lg = 24.0;
  
  /// Extra large spacing (32px)
  static const double xl = 32.0;
  
  /// Extra extra large spacing (48px)
  static const double xxl = 48.0;
  
  /// Extra extra extra large spacing (64px)
  static const double xxxl = 64.0;
}

/// Vertical spacing widget
///
/// Used to add vertical space between widgets.
class VSpace extends StatelessWidget {
  /// Creates a vertical space with the specified height.
  ///
  /// [height] is the amount of space in logical pixels.
  const VSpace(this.height, {super.key});
  
  /// Spacing amount in pixels
  final double height;

  /// Extra extra small vertical spacing (2px)
  static const xxs = VSpace(Spacing.xxs);
  
  /// Extra small vertical spacing (4px)
  static const xs = VSpace(Spacing.xs);

  /// Small vertical spacing (8px)
  static const sm = VSpace(Spacing.sm);

  /// Medium vertical spacing (16px)
  static const md = VSpace(Spacing.md);

  /// Large vertical spacing (24px)
  static const lg = VSpace(Spacing.lg);

  /// Extra large vertical spacing (32px)
  static const xl = VSpace(Spacing.xl);
  
  /// Extra extra large vertical spacing (48px)
  static const xxl = VSpace(Spacing.xxl);
  
  /// Extra extra extra large vertical spacing (64px)
  static const xxxl = VSpace(Spacing.xxxl);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

/// Horizontal spacing widget
///
/// Used to add horizontal space between widgets.
class HSpace extends StatelessWidget {
  /// Creates a horizontal space with the specified width.
  ///
  /// [width] is the amount of space in logical pixels.
  const HSpace(this.width, {super.key});
  
  /// Spacing amount in pixels
  final double width;

  /// Extra extra small horizontal spacing (2px)
  static const xxs = HSpace(Spacing.xxs);
  
  /// Extra small horizontal spacing (4px)
  static const xs = HSpace(Spacing.xs);

  /// Small horizontal spacing (8px)
  static const sm = HSpace(Spacing.sm);

  /// Medium horizontal spacing (16px)
  static const md = HSpace(Spacing.md);

  /// Large horizontal spacing (24px)
  static const lg = HSpace(Spacing.lg);

  /// Extra large horizontal spacing (32px)
  static const xl = HSpace(Spacing.xl);
  
  /// Extra extra large horizontal spacing (48px)
  static const xxl = HSpace(Spacing.xxl);
  
  /// Extra extra extra large horizontal spacing (64px)
  static const xxxl = HSpace(Spacing.xxxl);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

/// Responsive spacing that adapts to screen size
///
/// Values scale down on smaller screens.
class ResponsiveSpacing extends StatelessWidget {
  /// Creates a responsive spacing that adapts to screen size.
  ///
  /// [all] adds spacing in all directions.
  /// [horizontal] adds spacing horizontally.
  /// [vertical] adds spacing vertically.
  /// [top] adds spacing at the top.
  /// [right] adds spacing on the right.
  /// [bottom] adds spacing at the bottom.
  /// [left] adds spacing on the left.
  const ResponsiveSpacing({
    super.key,
    this.all,
    this.horizontal,
    this.vertical,
    this.top,
    this.right,
    this.bottom,
    this.left,
  });

  /// Extra extra small responsive spacing
  static const xxs = ResponsiveSpacing(all: Spacing.xxs);
  
  /// Extra small responsive spacing
  static const xs = ResponsiveSpacing(all: Spacing.xs);
  
  /// Small responsive spacing
  static const sm = ResponsiveSpacing(all: Spacing.sm);
  
  /// Medium responsive spacing
  static const md = ResponsiveSpacing(all: Spacing.md);
  
  /// Large responsive spacing
  static const lg = ResponsiveSpacing(all: Spacing.lg);
  
  /// Extra large responsive spacing
  static const xl = ResponsiveSpacing(all: Spacing.xl);
  
  /// Extra extra large responsive spacing
  static const xxl = ResponsiveSpacing(all: Spacing.xxl);

  /// Spacing in all directions
  final double? all;
  
  /// Horizontal spacing
  final double? horizontal;
  
  /// Vertical spacing
  final double? vertical;
  
  /// Top spacing
  final double? top;
  
  /// Right spacing
  final double? right;
  
  /// Bottom spacing
  final double? bottom;
  
  /// Left spacing
  final double? left;

  @override
  Widget build(BuildContext context) {
    // Calculate the factor based on screen width
    // Smaller screens get slightly reduced spacing
    final screenWidth = MediaQuery.of(context).size.width;
    final factor = _calculateFactor(screenWidth);
    
    return SizedBox(
      width: _calculateWidth(factor),
      height: _calculateHeight(factor),
    );
  }
  
  /// Calculate the scaling factor based on screen width
  double _calculateFactor(double screenWidth) {
    if (screenWidth < 360) return 0.75; // Small phones
    if (screenWidth < 600) return 0.85; // Normal phones
    if (screenWidth < 905) return 1.0;  // Large phones/small tablets
    if (screenWidth < 1240) return 1.1; // Tablets
    return 1.2; // Desktops
  }
  
  /// Calculate the width considering all horizontal spacing properties
  double? _calculateWidth(double factor) {
    if (all != null) return all! * factor;
    if (horizontal != null) return horizontal! * factor;
    
    // If we have any horizontal directional spacing
    if (left != null || right != null) {
      double width = 0;
      if (left != null) width += left! * factor;
      if (right != null) width += right! * factor;
      return width > 0 ? width : null;
    }
    
    return null;
  }
  
  /// Calculate the height considering all vertical spacing properties
  double? _calculateHeight(double factor) {
    if (all != null) return all! * factor;
    if (vertical != null) return vertical! * factor;
    
    // If we have any vertical directional spacing
    if (top != null || bottom != null) {
      double height = 0;
      if (top != null) height += top! * factor;
      if (bottom != null) height += bottom! * factor;
      return height > 0 ? height : null;
    }
    
    return null;
  }
}
