import '../../1_domain/entities/app_settings.dart';

/// Data model for app settings
class AppSettingsModel extends AppSettings {
  /// Creates app settings model
  const AppSettingsModel({
    super.themeMode,
    super.locale,
    super.notificationsEnabled,
    super.pushNotificationsEnabled,
    super.emailNotificationsEnabled,
    super.analyticsEnabled,
    super.autoPlayVideos,
    super.downloadOnWifiOnly,
    super.fontScale,
    super.customSettings,
    this.updatedAt,
  });

  /// When settings were last updated
  final DateTime? updatedAt;

  /// Creates settings model from JSON
  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
      themeMode: _themeModeFromString(json['themeMode'] as String?),
      locale: json['locale'] as String? ?? 'en_US',
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      pushNotificationsEnabled: json['pushNotificationsEnabled'] as bool? ?? true,
      emailNotificationsEnabled: json['emailNotificationsEnabled'] as bool? ?? true,
      analyticsEnabled: json['analyticsEnabled'] as bool? ?? true,
      autoPlayVideos: json['autoPlayVideos'] as bool? ?? true,
      downloadOnWifiOnly: json['downloadOnWifiOnly'] as bool? ?? true,
      fontScale: json['fontScale'] as double? ?? 1.0,
      customSettings: json['customSettings'] as Map<String, dynamic>? ?? {},
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'] as String) 
          : null,
    );
  }

  /// Converts model to JSON
  Map<String, dynamic> toJson() {
    return {
      'themeMode': _themeModeToString(themeMode),
      'locale': locale,
      'notificationsEnabled': notificationsEnabled,
      'pushNotificationsEnabled': pushNotificationsEnabled,
      'emailNotificationsEnabled': emailNotificationsEnabled,
      'analyticsEnabled': analyticsEnabled,
      'autoPlayVideos': autoPlayVideos,
      'downloadOnWifiOnly': downloadOnWifiOnly,
      'fontScale': fontScale,
      'customSettings': customSettings,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
  
  /// Creates a copy with modified fields
  AppSettingsModel copyWithModel({
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
    DateTime? updatedAt,
  }) {
    return AppSettingsModel(
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
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  /// Converts theme mode enum to string
  static String _themeModeToString(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
      default:
        return 'system';
    }
  }
  
  /// Converts string to theme mode enum
  static ThemeMode _themeModeFromString(String? value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }
}
