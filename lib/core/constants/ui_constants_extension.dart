import 'package:flutter/material.dart';

import 'app_spacing.dart';
import 'app_radius.dart';
import 'app_elevation.dart';
import 'app_duration.dart';

/// Extension on BuildContext to provide easy access to app constants
extension UIConstantsExtension on BuildContext {
  /// Spacing constants
  Map<String, double> get spacing => {
        'xs': AppSpacing.xs,
        's': AppSpacing.s,
        'm': AppSpacing.m,
        'l': AppSpacing.l,
        'xl': AppSpacing.xl,
        'xxl': AppSpacing.xxl,
        'xxxl': AppSpacing.xxxl,
        'huge': AppSpacing.huge,
      };

  /// Get a spacing value by name
  double getSpacing(String name) {
    assert(spacing.containsKey(name), 'Spacing "$name" does not exist');
    return spacing[name]!;
  }

  /// Radius constants
  Map<String, double> get radius => {
        'none': AppRadius.none,
        'xs': AppRadius.xs,
        's': AppRadius.s,
        'm': AppRadius.m,
        'l': AppRadius.l,
        'xl': AppRadius.xl,
        'xxl': AppRadius.xxl,
        'full': AppRadius.full,
      };

  /// Get a radius value by name
  double getRadius(String name) {
    assert(radius.containsKey(name), 'Radius "$name" does not exist');
    return radius[name]!;
  }

  /// Elevation constants
  Map<String, double> get elevation => {
        'none': AppElevation.none,
        'xs': AppElevation.xs,
        's': AppElevation.s,
        'm': AppElevation.m,
        'l': AppElevation.l,
        'xl': AppElevation.xl,
        'xxl': AppElevation.xxl,
      };

  /// Get an elevation value by name
  double getElevation(String name) {
    assert(elevation.containsKey(name), 'Elevation "$name" does not exist');
    return elevation[name]!;
  }

  /// Duration constants
  Map<String, int> get duration => {
        'extraFast': AppDuration.extraFast,
        'fast': AppDuration.fast,
        'medium': AppDuration.medium,
        'slow': AppDuration.slow,
        'extraSlow': AppDuration.extraSlow,
      };

  /// Get a duration value by name
  int getDuration(String name) {
    assert(duration.containsKey(name), 'Duration "$name" does not exist');
    return duration[name]!;
  }
}
