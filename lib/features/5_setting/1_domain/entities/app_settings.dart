/// Application settings entity
class AppSettings {
  /// Creates app settings entity
  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.locale = 'en_US',
    this.notificationsEnabled = true,
    this.pushNotificationsEnabled = true,
    this.emailNotificationsEnabled = true,
    this.analyticsEnabled = true,
    this.autoPlayVideos = true,
    this.downloadOnWifiOnly = true,
    this.fontScale = 1.0,
    this.customSettings = const {},
  });

  /// Theme mode (light, dark, system)
  final ThemeMode themeMode;
  
  /// App locale (language)
  final String locale;
  
  /// Whether notifications are enabled
  final bool notificationsEnabled;
  
  /// Whether push notifications are enabled
  final bool pushNotificationsEnabled;
  
  /// Whether email notifications are enabled
  final bool emailNotificationsEnabled;
  
  /// Whether analytics is enabled
  final bool analyticsEnabled;
  
  /// Whether videos auto-play
  final bool autoPlayVideos;
  
  /// Whether to download only on wifi
  final bool downloadOnWifiOnly;
  
  /// Font scale factor
  final double fontScale;
  
  /// Custom settings as key-value pairs
  final Map<String, dynamic> customSettings;

  /// Creates a copy with modified fields
  AppSettings copyWith({
    ThemeMode? themeMode,
    String? locale,
    bool? notificationsEnabled,
    bool? pushNotificationsEnabled,
    bool? emailNotificationsEnabled,
    bool? analyticsEnabled,
    bool? autoPlayVideos,
    bool? downloadOnWifiOnly,
    double? fontScale,
    Map<String, dynamic>? customSettings,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      pushNotificationsEnabled: pushNotificationsEnabled ?? this.pushNotificationsEnabled,
      emailNotificationsEnabled: emailNotificationsEnabled ?? this.emailNotificationsEnabled,
      analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled,
      autoPlayVideos: autoPlayVideos ?? this.autoPlayVideos,
      downloadOnWifiOnly: downloadOnWifiOnly ?? this.downloadOnWifiOnly,
      fontScale: fontScale ?? this.fontScale,
      customSettings: customSettings ?? this.customSettings,
    );
  }
}

/// Theme mode options
enum ThemeMode {
  /// System default theme
  system,
  
  /// Light theme
  light,
  
  /// Dark theme
  dark,
}
