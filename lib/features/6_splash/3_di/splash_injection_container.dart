import 'package:get_it/get_it.dart';
import '../1_domain/repositories/splash_repository.dart';
import '../1_domain/usecases/get_app_config_use_case.dart';
import '../1_domain/usecases/initialize_app_use_case.dart';
import '../1_domain/usecases/is_authenticated_use_case.dart';
import '../1_domain/usecases/get_splash_details_usecase.dart';
import '../1_domain/usecases/load_splash_details_use_case.dart';
import '../1_domain/usecases/get_splash_details_usecase_impl.dart';
import '../1_domain/usecases/load_splash_details_use_case_impl.dart';
import '../2_data/repositories/splash_repository_impl.dart';
import '../4_providers/splash_state_notifier.dart';
import '../4_providers/splash_details_state_notifier.dart';

/// Service locator for splash feature
final splashInjection = GetIt.instance;

/// Initialize splash feature dependencies
void initSplashFeature() {
  // Core
  _initializeCore();

  // Use Cases
  _initializeUseCases();

  // State management
  _initializeStateManagement();
}

/// Initialize core dependencies
void _initializeCore() {
  // Repositories
  splashInjection.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(),
  );
}

/// Initialize use cases
void _initializeUseCases() {
  // Register use cases
  splashInjection.registerLazySingleton<GetAppConfigUseCase>(
    () => GetAppConfigUseCase(splashInjection<SplashRepository>()),
  );
  
  splashInjection.registerLazySingleton<InitializeAppUseCase>(
    () => InitializeAppUseCase(splashInjection<SplashRepository>()),
  );
  
  splashInjection.registerLazySingleton<IsAuthenticatedUseCase>(
    () => IsAuthenticatedUseCase(splashInjection<SplashRepository>()),
  );
  
  splashInjection.registerLazySingleton<GetSplashDetailsUseCase>(
    () => GetSplashDetailsUseCaseImpl(),
  );
  
  splashInjection.registerLazySingleton<LoadSplashDetailsUseCase>(
    () => LoadSplashDetailsUseCaseImpl(),
  );
}

/// Initialize state management
void _initializeStateManagement() {
  // Register state notifiers
  splashInjection.registerFactory<SplashStateNotifier>(
    () => SplashStateNotifier(
      getAppConfigUseCase: splashInjection<GetAppConfigUseCase>(),
      initializeAppUseCase: splashInjection<InitializeAppUseCase>(),
      isAuthenticatedUseCase: splashInjection<IsAuthenticatedUseCase>(),
    ),
  );
  
  splashInjection.registerFactory<SplashDetailsStateNotifier>(
    () => SplashDetailsStateNotifier(
      getSplashDetailsUseCase: splashInjection<GetSplashDetailsUseCase>(),
      loadSplashDetailsUseCase: splashInjection<LoadSplashDetailsUseCase>(),
    ),
  );
}