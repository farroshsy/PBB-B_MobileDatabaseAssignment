import 'package:flutter/material.dart';

import 'app_spacing.dart';
import 'app_radius.dart';
import 'app_elevation.dart';
import 'app_duration.dart';

/// UI constants used throughout the application
///
/// These constants are used to maintain consistency across the UI
abstract class UiConstants {
  /// Default page padding
  static const pagePadding = EdgeInsets.all(16.0);
  
  /// Default section padding
  static const sectionPadding = EdgeInsets.symmetric(vertical: 8.0);
  
  // Layout breakpoints
  /// Max width for content containers
  static const maxContentWidth = 1200.0;
  
  /// Tablet breakpoint
  static const tabletBreakpoint = 768.0;
  
  /// Desktop breakpoint
  static const desktopBreakpoint = 1024.0;

  // Spacing - use app_spacing.dart for detailed spacing values
  /// Default spacing between elements - use AppSpacing.l for consistency
  static const defaultSpacing = AppSpacing.l; // 16.0
  
  /// Small spacing between elements - use AppSpacing.m for consistency
  static const smallSpacing = AppSpacing.m; // 8.0
  
  /// Large spacing between elements - use AppSpacing.xl for consistency
  static const largeSpacing = AppSpacing.xl; // 24.0
  
  /// Extra large spacing between elements - use AppSpacing.xxl for consistency
  static const extraLargeSpacing = AppSpacing.xxl; // 32.0
  
  // Radius - use app_radius.dart for detailed radius values
  /// Default border radius - use AppRadius.m for consistency
  static const defaultBorderRadius = AppRadius.m; // 8.0
  
  /// Small border radius - use AppRadius.s for consistency
  static const smallBorderRadius = AppRadius.s; // 4.0
  
  /// Large border radius - use AppRadius.l for consistency
  static const largeBorderRadius = AppRadius.l; // 16.0
  
  // Elevation - use app_elevation.dart for detailed elevation values
  /// Default card elevation - use AppElevation.s for consistency
  static const defaultElevation = AppElevation.s; // 2.0
  
  // Duration - use app_duration.dart for detailed duration values
  /// Default animation duration
  static const defaultAnimationDuration = Duration(milliseconds: AppDuration.medium); // 300ms
  
  /// Fast animation duration
  static const fastAnimationDuration = Duration(milliseconds: AppDuration.fast); // 150ms
  
  /// Slow animation duration
  static const slowAnimationDuration = Duration(milliseconds: AppDuration.slow); // 500ms
 
  /// Prevent instantiation
  const UiConstants._();
}
