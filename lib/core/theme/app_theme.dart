import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'theme_extensions.dart';

/// Application theme configuration
class AppTheme {
  AppTheme._();

  /// Creates the light theme
  static ThemeData lightTheme() {
    final baseTheme = ThemeData.light(useMaterial3: true);

    return baseTheme.copyWith(
      colorScheme: AppColors.lightColorScheme,

      // Apply the color scheme to the standard components
      primaryColor: AppColors.lightColorScheme.primary,
      scaffoldBackgroundColor: AppColors.lightColorScheme.surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),

      // Customize text theme
      textTheme: _buildTextTheme(baseTheme.textTheme, Colors.black),

      // Card theme
      cardTheme: CardTheme(
        color: AppColors.lightColorScheme.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Button themes
      elevatedButtonTheme:
          _buildElevatedButtonTheme(AppColors.lightColorScheme),
      textButtonTheme: _buildTextButtonTheme(AppColors.lightColorScheme),
      outlinedButtonTheme:
          _buildOutlinedButtonTheme(AppColors.lightColorScheme),

      // Input themes
      inputDecorationTheme:
          _buildInputDecorationTheme(AppColors.lightColorScheme),

      // Tab theme
      tabBarTheme: TabBarTheme(
        labelColor: AppColors.lightColorScheme.primary,
        unselectedLabelColor: AppColors.lightColorScheme.onSurfaceVariant,
        indicatorColor: AppColors.lightColorScheme.primary,
      ),

      // Bottom navigation theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightColorScheme.surface,
        selectedItemColor: AppColors.lightColorScheme.primary,
        unselectedItemColor: AppColors.lightColorScheme.onSurfaceVariant,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),

      // Extensions for custom theme properties
      extensions: <ThemeExtension<dynamic>>[
        const SpacingTheme(
            xs: 4.0, sm: 8.0, md: 16.0, lg: 24.0, xl: 32.0, xxl: 48.0),
        const BorderRadiusTheme(
            xs: 2.0, sm: 4.0, md: 8.0, lg: 16.0, xl: 24.0, circular: 1000.0),
        const ElevationTheme(
            none: 0.0, xs: 1.0, sm: 2.0, md: 4.0, lg: 8.0, xl: 16.0),
        const AnimationTheme(
          fast: Duration(milliseconds: 150),
          medium: Duration(milliseconds: 300),
          slow: Duration(milliseconds: 500),
          pageTransition: Duration(milliseconds: 300),
        ),
      ],
    );
  }

  /// Creates the dark theme
  static ThemeData darkTheme() {
    final baseTheme = ThemeData.dark(useMaterial3: true);

    return baseTheme.copyWith(
      colorScheme: AppColors.darkColorScheme,

      // Apply the color scheme to the standard components
      primaryColor: AppColors.darkColorScheme.primary,
      scaffoldBackgroundColor: AppColors.darkColorScheme.surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),

      // Customize text theme
      textTheme: _buildTextTheme(baseTheme.textTheme, Colors.white),

      // Card theme
      cardTheme: CardTheme(
        color: AppColors.darkColorScheme.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Button themes
      elevatedButtonTheme: _buildElevatedButtonTheme(AppColors.darkColorScheme),
      textButtonTheme: _buildTextButtonTheme(AppColors.darkColorScheme),
      outlinedButtonTheme: _buildOutlinedButtonTheme(AppColors.darkColorScheme),

      // Input themes
      inputDecorationTheme:
          _buildInputDecorationTheme(AppColors.darkColorScheme),

      // Tab theme
      tabBarTheme: TabBarTheme(
        labelColor: AppColors.darkColorScheme.primary,
        unselectedLabelColor: AppColors.darkColorScheme.onSurfaceVariant,
        indicatorColor: AppColors.darkColorScheme.primary,
      ),

      // Bottom navigation theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkColorScheme.surface,
        selectedItemColor: AppColors.darkColorScheme.primary,
        unselectedItemColor: AppColors.darkColorScheme.onSurfaceVariant,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),

      // Extensions for custom theme properties
      extensions: <ThemeExtension<dynamic>>[
        const SpacingTheme(
            xs: 4.0, sm: 8.0, md: 16.0, lg: 24.0, xl: 32.0, xxl: 48.0),
        const BorderRadiusTheme(
            xs: 2.0, sm: 4.0, md: 8.0, lg: 16.0, xl: 24.0, circular: 1000.0),
        const ElevationTheme(
            none: 0.0, xs: 1.0, sm: 2.0, md: 4.0, lg: 8.0, xl: 16.0),
        const AnimationTheme(
          fast: Duration(milliseconds: 150),
          medium: Duration(milliseconds: 300),
          slow: Duration(milliseconds: 500),
          pageTransition: Duration(milliseconds: 300),
        ),
      ],
    );
  }

  // Text theme
  static TextTheme _buildTextTheme(TextTheme base, Color textColor) {
    return base.copyWith(
      displayLarge: base.displayLarge!.copyWith(
        fontSize: 57,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      displayMedium: base.displayMedium!.copyWith(
        fontSize: 45,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      displaySmall: base.displaySmall!.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      headlineLarge: base.headlineLarge!.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      headlineMedium: base.headlineMedium!.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      headlineSmall: base.headlineSmall!.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      titleLarge: base.titleLarge!.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      titleMedium: base.titleMedium!.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      titleSmall: base.titleSmall!.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      bodyLarge: base.bodyLarge!.copyWith(
        fontSize: 16,
        color: textColor,
      ),
      bodyMedium: base.bodyMedium!.copyWith(
        fontSize: 14,
        color: textColor,
      ),
      bodySmall: base.bodySmall!.copyWith(
        fontSize: 12,
        color: Color.fromRGBO(
            textColor.r.toInt(), textColor.g.toInt(), textColor.b.toInt(), 0.8),
      ),
      labelLarge: base.labelLarge!.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelMedium: base.labelMedium!.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelSmall: base.labelSmall!.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(
            textColor.r.toInt(), textColor.g.toInt(), textColor.b.toInt(), 0.8),
      ),
    );
  }

  // Elevated Button Theme
  static ElevatedButtonThemeData _buildElevatedButtonTheme(
      ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        minimumSize: const Size(88, 48),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
      ),
    );
  }

  // Text Button Theme
  static TextButtonThemeData _buildTextButtonTheme(ColorScheme colorScheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        minimumSize: const Size(88, 36),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // Outlined Button Theme
  static OutlinedButtonThemeData _buildOutlinedButtonTheme(
      ColorScheme colorScheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        minimumSize: const Size(88, 48),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(color: colorScheme.primary),
      ),
    );
  }

  // Input Decoration Theme
  static InputDecorationTheme _buildInputDecorationTheme(
      ColorScheme colorScheme) {
    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: colorScheme.outline,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: colorScheme.outline,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: colorScheme.error,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: colorScheme.error,
          width: 2,
        ),
      ),
      labelStyle: TextStyle(
        color: colorScheme.onSurfaceVariant,
      ),
      hintStyle: TextStyle(
        color: Color.fromRGBO(
            colorScheme.onSurfaceVariant.r.toInt(),
            colorScheme.onSurfaceVariant.g.toInt(),
            colorScheme.onSurfaceVariant.b.toInt(),
            0.7),
      ),
    );
  }
}
