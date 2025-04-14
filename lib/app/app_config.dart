import '../core/config/app_config.dart' as core;
export '../core/config/app_config.dart';

/// Helper class that adapts the core AppConfig for app module usage
/// This class exists for backward compatibility with code that used the app-level config
class AppConfigHelper {
  /// Creates a helper for working with app config
  AppConfigHelper(this._coreConfig);

  final core.AppConfig _coreConfig;

  /// API base URL
  String get apiBaseUrl => _coreConfig.apiBaseUrl;

  /// Whether to show the debug banner
  bool get showDebugBanner => _coreConfig.showDebugBanner;

  /// Whether to enable detailed logging
  bool get enableLogging => _coreConfig.isLoggingEnabled;

  /// Timeout duration for API requests in seconds
  int get apiTimeoutSeconds => _coreConfig.apiTimeoutSeconds;

  /// Get the core AppConfig instance
  core.AppConfig get coreConfig => _coreConfig;

  /// Creates a helper for the development environment
  factory AppConfigHelper.development() {
    return AppConfigHelper(core.AppConfig.development());
  }

  /// Creates a helper for the staging environment
  factory AppConfigHelper.staging() {
    return AppConfigHelper(core.AppConfig.staging());
  }

  /// Creates a helper for the production environment
  factory AppConfigHelper.production() {
    return AppConfigHelper(core.AppConfig.production());
  }
}

// Re-export the core AppConfig as the default AppConfig for this file
// This allows code using "import 'app/app_config.dart'" to continue working
