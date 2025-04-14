import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/di/injection_container.dart' as di;
import '../3_di/splash_injection_container.dart';
import 'package:my_app/core/config/app_config.dart';
import '../1_domain/usecases/get_app_config_use_case.dart';
import '../1_domain/usecases/initialize_app_use_case.dart';
import '../1_domain/usecases/is_authenticated_use_case.dart';
import 'splash_state_notifier.dart';

/// Provider for the splash state notifier
final splashNotifierProvider = StateNotifierProvider<SplashStateNotifier, SplashState>((ref) {
  return SplashStateNotifier(
    getAppConfigUseCase: splashInjection<GetAppConfigUseCase>(),
    initializeAppUseCase: splashInjection<InitializeAppUseCase>(),
    isAuthenticatedUseCase: splashInjection<IsAuthenticatedUseCase>(),
  );
});

/// Provider for the splash loading state
final splashLoadingProvider = Provider<bool>((ref) {
  return ref.watch(splashNotifierProvider).isLoading;
});

/// Provider for the splash error message
final splashErrorProvider = Provider<String?>((ref) {
  return ref.watch(splashNotifierProvider).errorMessage;
});

/// Provider for the splash status
final splashStatusProvider = Provider<SplashStatus>((ref) {
  return ref.watch(splashNotifierProvider).status;
});

/// Provider for whether user is authenticated *based on splash check*
final isAuthenticatedProvider = Provider<bool>((ref) {
  // Depend on the splash status provider
  final status = ref.watch(splashStatusProvider);
  // Only return true if splash finished successfully and state indicates authenticated
  if (status == SplashStatus.success) {
      return ref.watch(splashNotifierProvider).isAuthenticated;
  }
  // Otherwise, assume not authenticated (or indeterminate)
  return false; 
});

/// Provider for app configuration
/// This provides the main app configuration, either from the splash state or directly from DI
final appConfigProvider = Provider<AppConfig>((ref) {
  // First try to get from splash state
  final splashAppConfig = ref.watch(splashNotifierProvider).appConfig;
  
  // If not available in splash state, get the singleton from DI
  // This ensures we always have an AppConfig available
  return splashAppConfig ?? di.sl<AppConfig>();
});