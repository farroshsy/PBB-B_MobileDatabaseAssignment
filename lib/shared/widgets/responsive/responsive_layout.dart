import 'package:flutter/material.dart';
import 'screen_type.dart';

/// A widget that renders different layouts based on screen size.
///
/// This widget helps create responsive UIs by allowing you to specify
/// different layouts for different screen sizes.
class ResponsiveLayout extends StatelessWidget {
  /// Creates a responsive layout.
  ///
  /// At least one builder must be provided.
  /// 
  /// [extraSmall] is for phones in portrait mode.
  /// [small] is for phones in landscape or small tablets.
  /// [medium] is for tablets in portrait mode.
  /// [large] is for tablets in landscape or small desktops.
  /// [extraLarge] is for desktops.
  const ResponsiveLayout({
    super.key,
    this.extraSmall,
    this.small,
    this.medium,
    this.large,
    this.extraLarge,
  }) : assert(
          extraSmall != null ||
              small != null ||
              medium != null ||
              large != null ||
              extraLarge != null,
          'At least one builder must be provided',
        );

  /// Builder for extra small screens (phones in portrait)
  final Widget Function(BuildContext)? extraSmall;
  
  /// Builder for small screens (phones in landscape, small tablets)
  final Widget Function(BuildContext)? small;
  
  /// Builder for medium screens (tablets in portrait)
  final Widget Function(BuildContext)? medium;
  
  /// Builder for large screens (tablets in landscape, small desktops)
  final Widget Function(BuildContext)? large;
  
  /// Builder for extra large screens (desktops)
  final Widget Function(BuildContext)? extraLarge;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenType = ScreenTypeUtil.getScreenType(constraints.maxWidth);
        
        switch (screenType) {
          case ScreenType.extraSmall:
            return extraSmall?.call(context) ?? 
                   small?.call(context) ?? 
                   medium?.call(context) ?? 
                   large?.call(context) ?? 
                   extraLarge!.call(context);
            
          case ScreenType.small:
            return small?.call(context) ?? 
                   medium?.call(context) ?? 
                   extraSmall?.call(context) ?? 
                   large?.call(context) ?? 
                   extraLarge!.call(context);
            
          case ScreenType.medium:
            return medium?.call(context) ?? 
                   large?.call(context) ?? 
                   small?.call(context) ?? 
                   extraSmall?.call(context) ?? 
                   extraLarge!.call(context);
            
          case ScreenType.large:
            return large?.call(context) ?? 
                   extraLarge?.call(context) ?? 
                   medium?.call(context) ?? 
                   small?.call(context) ?? 
                   extraSmall!.call(context);
            
          case ScreenType.extraLarge:
            return extraLarge?.call(context) ?? 
                   large?.call(context) ?? 
                   medium?.call(context) ?? 
                   small?.call(context) ?? 
                   extraSmall!.call(context);
        }
      },
    );
  }
}

/// A widget that renders different layouts based on screen orientation.
///
/// Use this when you need different layouts for portrait and landscape.
class OrientationLayout extends StatelessWidget {
  /// Creates an orientation-responsive layout.
  ///
  /// [portrait] is the layout for portrait orientation.
  /// [landscape] is the layout for landscape orientation.
  /// At least one must be provided.
  const OrientationLayout({
    super.key,
    this.portrait,
    this.landscape,
  }) : assert(
          portrait != null || landscape != null,
          'At least one of portrait or landscape must be provided',
        );

  /// Builder for portrait orientation
  final Widget Function(BuildContext)? portrait;
  
  /// Builder for landscape orientation
  final Widget Function(BuildContext)? landscape;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return portrait?.call(context) ?? landscape!.call(context);
        } else {
          return landscape?.call(context) ?? portrait!.call(context);
        }
      },
    );
  }
}

/// A widget that shows different content based on screen type.
///
/// Use this for simpler responsive adjustments where you just need
/// to select from different widgets based on screen size.
class ScreenTypeLayout extends StatelessWidget {
  /// Creates a screen type layout.
  ///
  /// At least one builder must be provided.
  const ScreenTypeLayout({
    super.key,
    this.mobile,
    this.tablet,
    this.desktop,
  }) : assert(
          mobile != null || tablet != null || desktop != null,
          'At least one of mobile, tablet, or desktop must be provided',
        );

  /// Widget for mobile screens (extra small and small)
  final Widget? mobile;
  
  /// Widget for tablet screens (medium)
  final Widget? tablet;
  
  /// Widget for desktop screens (large and extra large)
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    final screenType = ScreenTypeUtil.getScreenTypeFromContext(context);
    
    if (screenType == ScreenType.extraSmall || screenType == ScreenType.small) {
      return mobile ?? tablet ?? desktop!;
    } else if (screenType == ScreenType.medium) {
      return tablet ?? desktop ?? mobile!;
    } else {
      return desktop ?? tablet ?? mobile!;
    }
  }
}
