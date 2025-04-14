import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:my_app/features/0_auth/4_providers/auth_state_notifier.dart';

// Import with alias to resolve the conflict between the two AuthViewModel classes
import '../navigation/app_router.dart' as router;
import '../network/network_info.dart';
import '../network/dio_client.dart';

import '../network/connectivity_service.dart';
import '../storage/storage_service.dart';
import '../services/logger_service.dart';
import '../config/app_config.dart';
import '../config/env_config.dart';
import '../utils/date_utils.dart';
import '../utils/string_utils.dart';
import '../utils/validation_utils.dart';
import '../localization/app_localizations.dart';
import '../localization/localization_service.dart';

// Features injection containers
import '../../features/0_auth/3_di/auth_injection_container.dart' as auth_di;
import '../../features/6_splash/3_di/splash_injection_container.dart'
    as splash_di;
import '../../features/1_dashboard/3_di/dashboard_injection_container.dart' 
    as dashboard_di;
import '../../features/2_home/3_di/home_injection_container.dart' 
    as home_di;
import '../../features/3_notification/3_di/notification_injection_container.dart' 
    as notification_di;
import '../../features/4_profile/3_di/profile_injection_container.dart' 
    as profile_di;
import '../../features/5_setting/3_di/setting_injection_container.dart' 
    as setting_di;
// Import other feature DI containers as needed

/// Service locator singleton
final sl = GetIt.instance;

/// Initialize service locator dependency injection
Future<void> init() async {
  // Core
  await _initializeCore();

  // Features
  await _initializeFeatures();

  // External
  await _initializeExternal();
}

/// Initialize core dependencies
Future<void> _initializeCore() async {
  // Logger service
  sl.registerLazySingleton<LoggerService>(
    () => LoggerServiceImpl(),
  );

  // Connectivity service
  sl.registerLazySingleton<ConnectivityService>(
    () => ConnectivityService(),
  );

  // NetworkInfo
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<ConnectivityService>()),
  );

  // Dio client
  sl.registerLazySingleton<DioClient>(
    () => DioClient(createDioClient()),
  );

  // Storage service
  sl.registerLazySingleton<StorageService>(
    () => StorageServiceImpl(
      sharedPreferences: sl<SharedPreferences>(),
      secureStorage: sl<FlutterSecureStorage>(),
    ),
  );

  // Environment configuration
  sl.registerLazySingleton<EnvConfig>(
    () => EnvConfig(
      environment: Environment.development,
      values: {
        'apiBaseUrl': 'https://api.example.com/v1',
        'socketUrl': 'wss://socket.example.com',
        'timeout': 30000,
        'enableLogging': true,
      },
    ),
  );

  // Application configuration
  sl.registerLazySingleton<AppConfig>(
    () => AppConfig(),
  );

  // Utility services
  sl.registerLazySingleton<AppDateUtils>(
    () => AppDateUtils(),
  );

  sl.registerLazySingleton<StringUtils>(
    () => StringUtils(),
  );

  sl.registerLazySingleton<ValidationUtils>(
    () => ValidationUtils(),
  );

  // Localization service
  sl.registerLazySingleton<LocalizationService>(
    () => LocalizationService(),
  );

  // App localizations
  sl.registerLazySingleton<AppLocalizations>(
    () => AppLocalizations(const Locale('en', 'US')),
  );

  // Register the RouterAuthNotifier and inject AuthStateNotifier
  sl.registerLazySingleton<router.RouterAuthNotifier>(
    () => router.RouterAuthNotifier(sl<AuthStateNotifier>()), 
  );

  // App router
  sl.registerLazySingleton<router.AppRouter>(
    () => router.AppRouter(authViewModel: sl<router.RouterAuthNotifier>()),
  );
}

/// Initialize feature dependencies
Future<void> _initializeFeatures() async {
  // Auth
  await auth_di.initAuthDependencies();
  // Splash
  splash_di.initSplashFeature();
  // Dashboard
  dashboard_di.initDashboardFeature();
  // Home
  home_di.initHomeFeature();
  // Notification
  notification_di.initNotificationFeature();
  // Profile
  profile_di.initProfileFeature();
  // Setting - Temporarily commented out
  // setting_di.initSettingFeature(); 
}

/// Initialize external dependencies
Future<void> _initializeExternal() async {
  // SharedPreferences
  final preferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => preferences);

  // FlutterSecureStorage
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  // Dio - created and configured for easy consumption by features
  sl.registerLazySingleton<Dio>(() => createDioClient());
}

/// Create a new instance of Dio client
Dio createDioClient() {
  final dio = Dio();
  // Get AppConfig instance from GetIt
  final appConfig = sl<AppConfig>();

  // Add base options including the baseUrl from AppConfig
  dio.options = BaseOptions(
    baseUrl: appConfig.apiBaseUrl, // Set the base URL
    connectTimeout: Duration(seconds: appConfig.apiTimeoutSeconds), // Use config timeout
    receiveTimeout: Duration(seconds: appConfig.apiTimeoutSeconds), // Use config timeout
    sendTimeout: Duration(seconds: appConfig.apiTimeoutSeconds), // Use config timeout
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );

  // Add interceptors
  dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (object) {
        // Ensure LoggerService is registered before accessing
        if (sl.isRegistered<LoggerService>()) {
          sl<LoggerService>().debug(object.toString());
        } else {
          print("LoggerService not ready: $object"); // Fallback print
        }
      }));
  
  // TODO: Add other interceptors (e.g., for auth tokens)

  return dio;
}
