import 'package:flutter/material.dart';

/// Screen size categories for responsive design
enum ScreenType {
  /// Extra small screens (phones in portrait)
  extraSmall,
  
  /// Small screens (phones in landscape, small tablets)
  small,
  
  /// Medium screens (tablets in portrait)
  medium,
  
  /// Large screens (tablets in landscape, small desktops)
  large,
  
  /// Extra large screens (desktops)
  extraLarge,
}

/// Utility for detecting screen type
class ScreenTypeUtil {
  // Private constructor to prevent instantiation
  ScreenTypeUtil._();
  
  /// Breakpoint for extra small screens (0px)
  static const double extraSmallBreakpoint = 0.0;
  
  /// Breakpoint for small screens (600px)
  static const double smallBreakpoint = 600.0;
  
  /// Breakpoint for medium screens (905px)
  static const double mediumBreakpoint = 905.0;
  
  /// Breakpoint for large screens (1240px)
  static const double largeBreakpoint = 1240.0;
  
  /// Breakpoint for extra large screens (1440px)
  static const double extraLargeBreakpoint = 1440.0;
  
  /// Determines the screen type based on width
  static ScreenType getScreenType(double width) {
    if (width < smallBreakpoint) {
      return ScreenType.extraSmall;
    } else if (width < mediumBreakpoint) {
      return ScreenType.small;
    } else if (width < largeBreakpoint) {
      return ScreenType.medium;
    } else if (width < extraLargeBreakpoint) {
      return ScreenType.large;
    } else {
      return ScreenType.extraLarge;
    }
  }
  
  /// Determines the screen type based on the current context
  static ScreenType getScreenTypeFromContext(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return getScreenType(mediaQuery.size.width);
  }
  
  /// Checks if the screen is considered mobile (extra small or small)
  static bool isMobile(BuildContext context) {
    final screenType = getScreenTypeFromContext(context);
    return screenType == ScreenType.extraSmall || 
           screenType == ScreenType.small;
  }
  
  /// Checks if the screen is considered a tablet (medium)
  static bool isTablet(BuildContext context) {
    final screenType = getScreenTypeFromContext(context);
    return screenType == ScreenType.medium;
  }
  
  /// Checks if the screen is considered desktop (large or extra large)
  static bool isDesktop(BuildContext context) {
    final screenType = getScreenTypeFromContext(context);
    return screenType == ScreenType.large || 
           screenType == ScreenType.extraLarge;
  }
}
