import 'package:flutter/material.dart';
import 'app_text_styles.dart';

/// Typography system for the application
///
/// This class creates TextTheme objects for light and dark themes
/// using the raw TextStyle definitions from AppTextStyles.
class AppTypography {
  // Private constructor to prevent instantiation
  AppTypography._();

  /// Creates a TextTheme for light theme mode
  static TextTheme get lightTextTheme {
    return TextTheme(
      // Display styles
      displayLarge: AppTextStyles.displayLarge.copyWith(color: Colors.black87),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: Colors.black87),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: Colors.black87),
      
      // Headline styles
      headlineLarge: AppTextStyles.headlineLarge.copyWith(color: Colors.black87),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: Colors.black87),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(color: Colors.black87),
      
      // Title styles
      titleLarge: AppTextStyles.titleLarge.copyWith(color: Colors.black87),
      titleMedium: AppTextStyles.titleMedium.copyWith(color: Colors.black87),
      titleSmall: AppTextStyles.titleSmall.copyWith(color: Colors.black87),
      
      // Body styles
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: Colors.black87),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: Colors.black87),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: Colors.black54),
      
      // Label styles
      labelLarge: AppTextStyles.labelLarge.copyWith(color: Colors.black87),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: Colors.black87),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: Colors.black54),
    );
  }

  /// Creates a TextTheme for dark theme mode
  static TextTheme get darkTextTheme {
    return TextTheme(
      // Display styles
      displayLarge: AppTextStyles.displayLarge.copyWith(color: Colors.white),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: Colors.white),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: Colors.white),
      
      // Headline styles
      headlineLarge: AppTextStyles.headlineLarge.copyWith(color: Colors.white),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: Colors.white),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(color: Colors.white),
      
      // Title styles
      titleLarge: AppTextStyles.titleLarge.copyWith(color: Colors.white),
      titleMedium: AppTextStyles.titleMedium.copyWith(color: Colors.white),
      titleSmall: AppTextStyles.titleSmall.copyWith(color: Colors.white),
      
      // Body styles
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
      
      // Label styles
      labelLarge: AppTextStyles.labelLarge.copyWith(color: Colors.white),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: Colors.white),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: Colors.white70),
    );
  }
}
