import 'package:flutter/material.dart';

/// Spacing theme extension for consistent spacing throughout the app
class SpacingTheme extends ThemeExtension<SpacingTheme> {
  /// Creates a spacing theme
  const SpacingTheme({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
  });

  /// Extra small spacing
  final double xs;
  
  /// Small spacing
  final double sm;
  
  /// Medium spacing
  final double md;
  
  /// Large spacing
  final double lg;
  
  /// Extra large spacing
  final double xl;
  
  /// Double extra large spacing
  final double xxl;

  /// Light theme spacing values
  factory SpacingTheme.light() {
    return const SpacingTheme(
      xs: 4.0,
      sm: 8.0,
      md: 16.0,
      lg: 24.0,
      xl: 32.0,
      xxl: 48.0,
    );
  }

  /// Dark theme spacing values
  factory SpacingTheme.dark() {
    return const SpacingTheme(
      xs: 4.0,
      sm: 8.0,
      md: 16.0,
      lg: 24.0,
      xl: 32.0,
      xxl: 48.0,
    );
  }

  @override
  ThemeExtension<SpacingTheme> copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) {
    return SpacingTheme(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
    );
  }

  @override
  ThemeExtension<SpacingTheme> lerp(
    covariant ThemeExtension<SpacingTheme>? other,
    double t,
  ) {
    if (other is! SpacingTheme) {
      return this;
    }

    return SpacingTheme(
      xs: lerpDouble(xs, other.xs, t)!,
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      xl: lerpDouble(xl, other.xl, t)!,
      xxl: lerpDouble(xxl, other.xxl, t)!,
    );
  }
}

/// Border radius theme extension for consistent rounding throughout the app
class BorderRadiusTheme extends ThemeExtension<BorderRadiusTheme> {
  /// Creates a border radius theme
  const BorderRadiusTheme({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.circular,
  });

  /// Extra small border radius
  final double xs;
  
  /// Small border radius
  final double sm;
  
  /// Medium border radius
  final double md;
  
  /// Large border radius
  final double lg;
  
  /// Extra large border radius
  final double xl;
  
  /// Circular border radius (50%)
  final double circular;

  /// Light theme border radius values
  factory BorderRadiusTheme.light() {
    return const BorderRadiusTheme(
      xs: 2.0,
      sm: 4.0,
      md: 8.0,
      lg: 16.0,
      xl: 24.0,
      circular: 1000.0, // Large value for circular
    );
  }

  /// Dark theme border radius values
  factory BorderRadiusTheme.dark() {
    return const BorderRadiusTheme(
      xs: 2.0,
      sm: 4.0,
      md: 8.0,
      lg: 16.0,
      xl: 24.0,
      circular: 1000.0, // Large value for circular
    );
  }

  @override
  ThemeExtension<BorderRadiusTheme> copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? circular,
  }) {
    return BorderRadiusTheme(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      circular: circular ?? this.circular,
    );
  }

  @override
  ThemeExtension<BorderRadiusTheme> lerp(
    covariant ThemeExtension<BorderRadiusTheme>? other,
    double t,
  ) {
    if (other is! BorderRadiusTheme) {
      return this;
    }

    return BorderRadiusTheme(
      xs: lerpDouble(xs, other.xs, t)!,
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      xl: lerpDouble(xl, other.xl, t)!,
      circular: lerpDouble(circular, other.circular, t)!,
    );
  }
}

/// Elevation theme extension for consistent shadows throughout the app
class ElevationTheme extends ThemeExtension<ElevationTheme> {
  /// Creates an elevation theme
  const ElevationTheme({
    required this.none,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  /// No elevation
  final double none;
  
  /// Extra small elevation
  final double xs;
  
  /// Small elevation
  final double sm;
  
  /// Medium elevation
  final double md;
  
  /// Large elevation
  final double lg;
  
  /// Extra large elevation
  final double xl;

  /// Light theme elevation values
  factory ElevationTheme.light() {
    return const ElevationTheme(
      none: 0.0,
      xs: 1.0,
      sm: 2.0,
      md: 4.0,
      lg: 8.0,
      xl: 16.0,
    );
  }

  /// Dark theme elevation values
  factory ElevationTheme.dark() {
    return const ElevationTheme(
      none: 0.0,
      xs: 1.0,
      sm: 2.0,
      md: 4.0,
      lg: 8.0,
      xl: 16.0,
    );
  }

  @override
  ThemeExtension<ElevationTheme> copyWith({
    double? none,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return ElevationTheme(
      none: none ?? this.none,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }

  @override
  ThemeExtension<ElevationTheme> lerp(
    covariant ThemeExtension<ElevationTheme>? other,
    double t,
  ) {
    if (other is! ElevationTheme) {
      return this;
    }

    return ElevationTheme(
      none: lerpDouble(none, other.none, t)!,
      xs: lerpDouble(xs, other.xs, t)!,
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      xl: lerpDouble(xl, other.xl, t)!,
    );
  }
}

/// Animation theme extension for consistent animation durations throughout the app
class AnimationTheme extends ThemeExtension<AnimationTheme> {
  /// Creates an animation theme
  const AnimationTheme({
    required this.fast,
    required this.medium,
    required this.slow,
    required this.pageTransition,
  });

  /// Fast animation duration
  final Duration fast;
  
  /// Medium animation duration
  final Duration medium;
  
  /// Slow animation duration
  final Duration slow;
  
  /// Page transition animation duration
  final Duration pageTransition;

  /// Light theme animation duration values
  factory AnimationTheme.light() {
    return const AnimationTheme(
      fast: Duration(milliseconds: 150),
      medium: Duration(milliseconds: 300),
      slow: Duration(milliseconds: 500),
      pageTransition: Duration(milliseconds: 300),
    );
  }

  /// Dark theme animation duration values
  factory AnimationTheme.dark() {
    return const AnimationTheme(
      fast: Duration(milliseconds: 150),
      medium: Duration(milliseconds: 300),
      slow: Duration(milliseconds: 500),
      pageTransition: Duration(milliseconds: 300),
    );
  }

  @override
  ThemeExtension<AnimationTheme> copyWith({
    Duration? fast,
    Duration? medium,
    Duration? slow,
    Duration? pageTransition,
  }) {
    return AnimationTheme(
      fast: fast ?? this.fast,
      medium: medium ?? this.medium,
      slow: slow ?? this.slow,
      pageTransition: pageTransition ?? this.pageTransition,
    );
  }

  @override
  ThemeExtension<AnimationTheme> lerp(
    covariant ThemeExtension<AnimationTheme>? other,
    double t,
  ) {
    if (other is! AnimationTheme) {
      return this;
    }

    return AnimationTheme(
      fast: lerpDuration(fast, other.fast, t),
      medium: lerpDuration(medium, other.medium, t),
      slow: lerpDuration(slow, other.slow, t),
      pageTransition: lerpDuration(pageTransition, other.pageTransition, t),
    );
  }
}

/// Lerp a double value
double? lerpDouble(double a, double b, double t) {
  return a + (b - a) * t;
}

/// Lerp a duration value
Duration lerpDuration(Duration a, Duration b, double t) {
  return Duration(
    milliseconds: (a.inMilliseconds + (b.inMilliseconds - a.inMilliseconds) * t)
        .round(),
  );
}

/// Extension methods for theme access
extension ThemeExtensions on ThemeData {
  /// Get the spacing theme
  SpacingTheme get spacing => extension<SpacingTheme>()!;
  
  /// Get the border radius theme
  BorderRadiusTheme get borderRadius => extension<BorderRadiusTheme>()!;
  
  /// Get the elevation theme
  ElevationTheme get elevation => extension<ElevationTheme>()!;
  
  /// Get the animation theme
  AnimationTheme get animation => extension<AnimationTheme>()!;
}
