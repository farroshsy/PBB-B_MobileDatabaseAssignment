import 'package:flutter/material.dart';

/// Application color palette
///
/// Contains all colors used throughout the application for both light and dark themes
class AppColors {
  AppColors._();

  // Light Theme Colors
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF2196F3), // Blue
    onPrimary: Color(0xFFFFFFFF), // White
    primaryContainer: Color(0xFFCBE6FF), // Light Blue
    onPrimaryContainer: Color(0xFF001D31), // Dark Blue

    secondary: Color(0xFF9C27B0), // Purple
    onSecondary: Color(0xFFFFFFFF), // White
    secondaryContainer: Color(0xFFF3D8FD), // Light Purple
    onSecondaryContainer: Color(0xFF3E0043), // Dark Purple

    tertiary: Color(0xFF4CAF50), // Green
    onTertiary: Color(0xFFFFFFFF), // White
    tertiaryContainer: Color(0xFFB8F5B6), // Light Green
    onTertiaryContainer: Color(0xFF002203), // Dark Green

    error: Color(0xFFB00020), // Red
    onError: Color(0xFFFFFFFF), // White
    errorContainer: Color(0xFFFDCDD3), // Light Red
    onErrorContainer: Color(0xFF410008), // Dark Red

    surface: Color(0xFFFAFAFA), // Very Light Grey (was background)
    onSurface: Color(0xFF1C1B1F), // Very Dark Grey (was onBackground)

    outline: Color(0xFF757780), // Medium Grey
    outlineVariant: Color(0xFFC5C6D0), // Light Grey

    surfaceContainerHighest:
        Color(0xFFE7E0EC), // Light Purple Grey (was surfaceVariant)
    onSurfaceVariant: Color(0xFF49454F), // Dark Purple Grey

    inverseSurface: Color(0xFF313033), // Dark Grey
    onInverseSurface: Color(0xFFF4EFF4), // Very Light Grey
    inversePrimary: Color(0xFF9ECAFF), // Light Blue

    shadow: Color(0xFF000000), // Black
    scrim: Color(0xFF000000), // Black
    surfaceTint: Color(0xFF2196F3), // Blue
  );

  // Dark Theme Colors
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF90CAF9), // Light Blue
    onPrimary: Color(0xFF003355), // Dark Blue
    primaryContainer: Color(0xFF004881), // Medium Blue
    onPrimaryContainer: Color(0xFFCBE6FF), // Light Blue

    secondary: Color(0xFFCE93D8), // Light Purple
    onSecondary: Color(0xFF3E0043), // Dark Purple
    secondaryContainer: Color(0xFF7B1FA2), // Medium Purple
    onSecondaryContainer: Color(0xFFF3D8FD), // Light Purple

    tertiary: Color(0xFFA5D6A7), // Light Green
    onTertiary: Color(0xFF002203), // Dark Green
    tertiaryContainer: Color(0xFF2E7D32), // Medium Green
    onTertiaryContainer: Color(0xFFB8F5B6), // Light Green

    error: Color(0xFFCF6679), // Light Red
    onError: Color(0xFF640B14), // Dark Red
    errorContainer: Color(0xFF8B0016), // Medium Red
    onErrorContainer: Color(0xFFF9DEDC), // Light Red

    surface: Color(0xFF121212), // Very Dark Grey (was background)
    onSurface: Color(0xFFE3E3E3), // Very Light Grey (was onBackground)

    outline: Color(0xFF8E9099), // Medium Grey
    outlineVariant: Color(0xFF444547), // Dark Grey

    surfaceContainerHighest:
        Color(0xFF2F2F2F), // Dark Grey (was surfaceVariant)
    onSurfaceVariant: Color(0xFFCACACA), // Light Grey

    inverseSurface: Color(0xFFE3E3E3), // Very Light Grey
    onInverseSurface: Color(0xFF1C1B1F), // Very Dark Grey
    inversePrimary: Color(0xFF1976D2), // Medium Blue

    shadow: Color(0xFF000000), // Black
    scrim: Color(0xFF000000), // Black
    surfaceTint: Color(0xFF90CAF9), // Light Blue
  );

  // Specific shared colors for both themes
  static const Color transparent = Colors.transparent;
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF9C27B0), Color(0xFF7B1FA2)],
  );
}
