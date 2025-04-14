/// Configuration for the application
///
/// This class provides configuration options that can be toggled
/// to change application behavior. It follows the singleton pattern
/// to ensure consistent configuration across the app.
class AppConfig {
  // Private constructor for singleton
  AppConfig._();
  
  // Singleton instance
  static final AppConfig _instance = AppConfig._();
  
  // Factory constructor to access instance
  factory AppConfig() => _instance;
  
  /// Whether the app is in development mode
  ///
  /// When true, additional debugging features are enabled
  bool _devMode = false;
  
  /// Whether to show Widgetbook instead of the main app
  ///
  /// When true, the app will launch in Widgetbook mode
  /// for UI component development and documentation
  bool _widgetbookMode = false;
  
  /// The environment the app is running in
  ///
  /// Possible values: 'development', 'staging', 'production'
  String _environment = 'development';
  
  /// API base URL for the current environment
  /// Will be set based on environment
  String _apiBaseUrl = '';
  
  /// Whether to enable analytics
  bool _analyticsEnabled = false;
  
  /// Whether to enable crash reporting
  bool _crashReportingEnabled = false;
  
  /// Whether to enable logging
  bool _loggingEnabled = true;
  
  /// Enable mock data for offline development
  bool _useMockData = false;
  
  /// Whether to show debug banner
  bool _showDebugBanner = true;
  
  /// API timeout in seconds
  int _apiTimeoutSeconds = 30;
  
  /// Fields for maintenance and version checks
  String? _maintenanceMessage;
  String _appVersion = '1.0.0'; // Default app version
  String _buildNumber = '1'; // Default build number
  String _minimumRequiredVersion = '1.0.0'; // Default minimum version
  String? _updateUrl;
  String _updateMessage = 'A new version is available. Please update the app to continue.';
  
  /// Feature flags
  Map<String, dynamic> _featureFlags = {};
  
  // Getters
  bool get isDevMode => _devMode;
  bool get isWidgetbookMode => _widgetbookMode;
  String get environment => _environment;
  String get apiBaseUrl => _apiBaseUrl;
  bool get isAnalyticsEnabled => _analyticsEnabled;
  bool get isCrashReportingEnabled => _crashReportingEnabled;
  bool get isLoggingEnabled => _loggingEnabled;
  bool get useMockData => _useMockData;
  bool get showDebugBanner => _showDebugBanner;
  int get apiTimeoutSeconds => _apiTimeoutSeconds;
  
  // Version and maintenance getters
  bool get isInMaintenance => _maintenanceMessage != null;
  String? get maintenanceMessage => _maintenanceMessage;
  String get appVersion => _appVersion;
  String get buildNumber => _buildNumber;
  String get minimumRequiredVersion => _minimumRequiredVersion;
  bool get requiresUpdate => _compareVersions(_appVersion, _minimumRequiredVersion) < 0;
  String? get updateUrl => _updateUrl;
  String get updateMessage => _updateMessage;
  Map<String, dynamic> get featureFlags => _featureFlags;
  
  /// Initialize the configuration for a specific environment
  ///
  /// This should be called at the start of the application
  void init({
    required String environment,
    bool? devMode,
    bool? widgetbookMode,
    bool? analyticsEnabled,
    bool? crashReportingEnabled,
    bool? loggingEnabled,
    bool? useMockData,
    bool? showDebugBanner,
    int? apiTimeoutSeconds,
    String? maintenanceMessage,
    String? appVersion,
    String? buildNumber,
    String? minimumRequiredVersion,
    String? updateUrl,
    String? updateMessage,
    Map<String, dynamic>? featureFlags,
  }) {
    _environment = environment;
    _devMode = devMode ?? (environment != 'production');
    _widgetbookMode = widgetbookMode ?? false;
    _analyticsEnabled = analyticsEnabled ?? (environment == 'production');
    _crashReportingEnabled = crashReportingEnabled ?? (environment == 'production');
    _loggingEnabled = loggingEnabled ?? true;
    _useMockData = useMockData ?? false;
    _showDebugBanner = showDebugBanner ?? _devMode;
    _apiTimeoutSeconds = apiTimeoutSeconds ?? 30;
    
    // Initialize version and maintenance fields
    _maintenanceMessage = maintenanceMessage;
    _appVersion = appVersion ?? _appVersion;
    _buildNumber = buildNumber ?? _buildNumber;
    _minimumRequiredVersion = minimumRequiredVersion ?? _minimumRequiredVersion;
    _updateUrl = updateUrl;
    _updateMessage = updateMessage ?? _updateMessage;
    _featureFlags = featureFlags ?? {};
    
    // Set API base URL based on environment
    switch (environment) {
      case 'development':
        _apiBaseUrl = 'https://dev-api.example.com';
        break;
      case 'staging':
        _apiBaseUrl = 'https://staging-api.example.com';
        break;
      case 'production':
        _apiBaseUrl = 'https://api.example.com';
        break;
      default:
        _apiBaseUrl = 'https://dev-api.example.com';
    }
  }
  
  /// Get a specific environment configuration
  /// Factory methods to easily create config for specific environments
  
  /// Development environment configuration
  factory AppConfig.development() {
    final config = AppConfig();
    config.init(
      environment: 'development',
      devMode: true,
      showDebugBanner: true,
      loggingEnabled: true,
      apiTimeoutSeconds: 30,
    );
    return config;
  }
  
  /// Staging environment configuration
  factory AppConfig.staging() {
    final config = AppConfig();
    config.init(
      environment: 'staging',
      devMode: true,
      showDebugBanner: true,
      loggingEnabled: true,
      apiTimeoutSeconds: 30,
    );
    return config;
  }
  
  /// Production environment configuration
  factory AppConfig.production() {
    final config = AppConfig();
    config.init(
      environment: 'production',
      devMode: false,
      showDebugBanner: false,
      loggingEnabled: false,
      analyticsEnabled: true,
      crashReportingEnabled: true,
      apiTimeoutSeconds: 30,
    );
    return config;
  }
  
  /// Toggle development mode
  void setDevMode(bool enabled) {
    _devMode = enabled;
  }
  
  /// Toggle Widgetbook mode
  void setWidgetbookMode(bool enabled) {
    _widgetbookMode = enabled;
  }
  
  /// Toggle mock data usage
  void setUseMockData(bool enabled) {
    _useMockData = enabled;
  }
  
  /// Reset configuration to defaults
  void reset() {
    _environment = 'development';
    _devMode = true;
    _widgetbookMode = false;
    _analyticsEnabled = false;
    _crashReportingEnabled = false;
    _loggingEnabled = true;
    _useMockData = false;
    _showDebugBanner = true;
    _apiTimeoutSeconds = 30;
    _apiBaseUrl = 'https://dev-api.example.com';
    _maintenanceMessage = null;
    _appVersion = '1.0.0'; 
    _buildNumber = '1';
    _minimumRequiredVersion = '1.0.0';
    _updateUrl = null;
    _updateMessage = 'A new version is available. Please update the app to continue.';
    _featureFlags = {};
  }
  
  /// Get configuration summary
  Map<String, dynamic> getConfigSummary() {
    return {
      'environment': _environment,
      'devMode': _devMode,
      'widgetbookMode': _widgetbookMode,
      'apiBaseUrl': _apiBaseUrl,
      'apiTimeoutSeconds': _apiTimeoutSeconds,
      'showDebugBanner': _showDebugBanner,
      'analyticsEnabled': _analyticsEnabled,
      'crashReportingEnabled': _crashReportingEnabled,
      'loggingEnabled': _loggingEnabled,
      'useMockData': _useMockData,
      'isInMaintenance': isInMaintenance,
      'maintenanceMessage': _maintenanceMessage,
      'appVersion': _appVersion,
      'buildNumber': _buildNumber,
      'minimumRequiredVersion': _minimumRequiredVersion,
      'requiresUpdate': requiresUpdate,
      'updateUrl': _updateUrl,
      'updateMessage': _updateMessage,
      'featureFlags': _featureFlags,
    };
  }

  /// Create a copy of this config with modified values
  AppConfig copyWith({
    String? environment,
    bool? devMode,
    bool? widgetbookMode,
    bool? analyticsEnabled,
    bool? crashReportingEnabled,
    bool? loggingEnabled,
    bool? useMockData,
    bool? showDebugBanner,
    int? apiTimeoutSeconds,
    String? maintenanceMessage,
    String? appVersion,
    String? buildNumber,
    String? minimumRequiredVersion,
    String? updateUrl,
    String? updateMessage,
    Map<String, dynamic>? featureFlags,
    bool clearMaintenanceMessage = false,
  }) {
    final config = AppConfig();
    config.init(
      environment: environment ?? _environment,
      devMode: devMode ?? _devMode,
      widgetbookMode: widgetbookMode ?? _widgetbookMode,
      analyticsEnabled: analyticsEnabled ?? _analyticsEnabled,
      crashReportingEnabled: crashReportingEnabled ?? _crashReportingEnabled,
      loggingEnabled: loggingEnabled ?? _loggingEnabled,
      useMockData: useMockData ?? _useMockData,
      showDebugBanner: showDebugBanner ?? _showDebugBanner,
      apiTimeoutSeconds: apiTimeoutSeconds ?? _apiTimeoutSeconds,
      maintenanceMessage: clearMaintenanceMessage ? null : (maintenanceMessage ?? _maintenanceMessage),
      appVersion: appVersion ?? _appVersion,
      buildNumber: buildNumber ?? _buildNumber,
      minimumRequiredVersion: minimumRequiredVersion ?? _minimumRequiredVersion,
      updateUrl: updateUrl ?? _updateUrl,
      updateMessage: updateMessage ?? _updateMessage,
      featureFlags: featureFlags ?? Map.from(_featureFlags),
    );
    return config;
  }

  // Add a simple version comparison helper (adjust if using semver package)
  int _compareVersions(String version1, String version2) {
    // Strip build metadata before comparing (e.g., "1.0.0+1" becomes "1.0.0")
    String coreV1 = version1.split('+').first;
    String coreV2 = version2.split('+').first;

    List<int> parts1 = coreV1.split('.').map(int.parse).toList();
    List<int> parts2 = coreV2.split('.').map(int.parse).toList();
    for (int i = 0; i < 3; i++) {
      int p1 = (i < parts1.length) ? parts1[i] : 0;
      int p2 = (i < parts2.length) ? parts2[i] : 0;
      if (p1 < p2) return -1;
      if (p1 > p2) return 1;
    }
    return 0;
  }
  
  @override
  String toString() {
    return 'AppConfig(environment: $_environment, appVersion: $_appVersion)';
  }
}
