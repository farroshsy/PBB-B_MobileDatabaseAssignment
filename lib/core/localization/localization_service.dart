/// Service for managing application localization
///
/// Provides methods for changing locale, getting current locale,
/// and supporting localization throughout the app.
library;
import 'package:flutter/material.dart';

class LocalizationService {
  // List of supported locales
  static final List<Locale> supportedLocales = [
    const Locale('en', 'US'),
    const Locale('es', 'ES'),
    const Locale('fr', 'FR'),
    // Add more locales as needed
  ];

  // Default locale
  static const Locale fallbackLocale = Locale('en', 'US');
  
  // Current locale
  static Locale _currentLocale = fallbackLocale;
  
  // Locale change callback
  static Function(Locale)? _onLocaleChanged;
  
  /// Get the current locale
  static Locale get currentLocale => _currentLocale;
  
  /// Set locale change callback
  static set onLocaleChanged(Function(Locale) callback) {
    _onLocaleChanged = callback;
  }
  
  /// Change the application locale
  static Future<void> changeLocale(String languageCode) async {
    // Find the locale in the supported locales
    final Locale newLocale = supportedLocales.firstWhere(
      (locale) => locale.languageCode == languageCode,
      orElse: () => fallbackLocale,
    );
    
    // Only trigger if locale is different
    if (_currentLocale != newLocale) {
      _currentLocale = newLocale;
      
      // Notify listeners
      if (_onLocaleChanged != null) {
        _onLocaleChanged!(newLocale);
      }
    }
  }
  
  /// Get the locale name for a given locale code
  static String getDisplayLanguage(String languageCode) {
    switch (languageCode) {
      case 'en': return 'English';
      case 'es': return 'Español';
      case 'fr': return 'Français';
      default: return 'Unknown';
    }
  }

  /// Check if a language is supported
  static bool isSupported(String languageCode) {
    return supportedLocales.any((locale) => locale.languageCode == languageCode);
  }
}
