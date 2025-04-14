/// Application-wide constants
///
/// This class contains constants used throughout the application.
/// It helps centralize values that should not change but need to be referenced
/// in multiple places.
class AppConstants {
  // API Constants
  static const int apiTimeoutSeconds = 30;
  static const int maxRetryAttempts = 3;
  static const int retryDelayMilliseconds = 1000;
  
  // Cache Constants
  static const int defaultCacheDurationMinutes = 60;
  static const int maxCacheItems = 100;
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 50;
  
  // Animation
  static const int defaultAnimationDurationMs = 300;
  
  // General
  static const String appName = 'My Flutter App';
  static const String appVersion = '1.0.0';
  
  // Company Information (moved from shared/constants)
  static const String companyName = 'Example Company';
  static const String copyright = '© 2023 Example Company. All rights reserved.';
  static const String supportEmail = 'support@example.com';
  
  // Legal URLs (moved from shared/constants)
  static const String privacyPolicyUrl = 'https://example.com/privacy';
  static const String termsOfServiceUrl = 'https://example.com/terms';
  
  // Do not allow instantiation
  const AppConstants._();
}
