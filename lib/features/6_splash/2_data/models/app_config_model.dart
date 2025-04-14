import 'package:my_app/core/config/app_config.dart';

/// Data model for app configuration
class AppConfigModel {
  /// Creates app config model
  const AppConfigModel({
    required this.appConfig,
    this.serverTime,
  });

  /// Core app configuration 
  final AppConfig appConfig;
  
  /// Current server time
  final DateTime? serverTime;

  /// Creates app config model from JSON
  factory AppConfigModel.fromJson(Map<String, dynamic> json) {
    final config = AppConfig();
    config.init(
      environment: json['environment'] as String? ?? 'development',
      appVersion: json['appVersion'] as String? ?? '1.0.0',
      buildNumber: json['buildNumber'] as String? ?? '1',
      minimumRequiredVersion: json['minimumRequiredVersion'] as String?,
      updateUrl: json['updateUrl'] as String?,
      maintenanceMessage: json['maintenanceMode'] == true ? 
          (json['maintenanceMessage'] as String? ?? 'App is currently under maintenance.') : null,
      updateMessage: json['updateMessage'] as String?,
      featureFlags: json['featureFlags'] as Map<String, dynamic>? ?? {},
    );
    
    return AppConfigModel(
      appConfig: config,
      serverTime: json['serverTime'] != null 
          ? DateTime.parse(json['serverTime'] as String) 
          : null,
    );
  }

  /// Converts model to JSON
  Map<String, dynamic> toJson() {
    return {
      'environment': appConfig.environment,
      'appVersion': appConfig.appVersion,
      'buildNumber': appConfig.buildNumber,
      'requiresUpdate': appConfig.requiresUpdate,
      'minimumRequiredVersion': appConfig.minimumRequiredVersion,
      'updateUrl': appConfig.updateUrl,
      'maintenanceMode': appConfig.isInMaintenance,
      'maintenanceMessage': appConfig.maintenanceMessage,
      'updateMessage': appConfig.updateMessage,
      'featureFlags': appConfig.featureFlags,
      'serverTime': serverTime?.toIso8601String(),
    };
  }
}
