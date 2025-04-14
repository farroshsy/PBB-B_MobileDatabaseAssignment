import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Theme configuration for the application
///
/// This module provides theme-related functionality and can be used
/// for dependency injection of theme services.
class ThemeModule {
  /// Initialize the theme module
  static void init() {
    // Additional initialization can be added here
    // such as loading theme preferences from storage
  }

  /// Get the appropriate theme data based on theme mode
  static ThemeData getThemeData(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return AppTheme.lightTheme(); // Now calling the function
      case ThemeMode.dark:
        return AppTheme.darkTheme(); // Now calling the function
      case ThemeMode.system:
        // For system theme, we need to check the platform brightness
        // but for preview/example purposes, we'll default to light
        return AppTheme.lightTheme(); // Now calling the function
    }
  }
}

/// Theme provider for managing theme state
///
/// This provider allows changing between light and dark themes
/// and notifies listeners when the theme changes.
class ThemeProvider extends ChangeNotifier {
  /// Current theme mode
  ThemeMode _themeMode = ThemeMode.system;

  /// Get the current theme mode
  ThemeMode get themeMode => _themeMode;

  /// Get the current theme data based on the theme mode
  ThemeData get themeData => ThemeModule.getThemeData(_themeMode);

  /// Set the theme mode
  void setThemeMode(ThemeMode themeMode) {
    if (_themeMode != themeMode) {
      _themeMode = themeMode;
      notifyListeners();
      // Here you would also persist the setting
    }
  }

  /// Toggle between light and dark themes
  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    // Here you would also persist the setting
  }
}
