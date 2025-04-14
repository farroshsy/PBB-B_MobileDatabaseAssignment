import 'package:get_it/get_it.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // Removed
// import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Removed
import '../../../core/di/injection_container.dart' as core_di;
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_info.dart';
// import '../../../core/network/connectivity_service.dart'; // Removed
import '../../../core/storage/storage_service.dart';
import '../1_domain/repositories/auth_repository.dart';
import '../1_domain/usecases/get_current_user_use_case.dart';
import '../1_domain/usecases/send_password_reset_email_use_case.dart';
import '../1_domain/usecases/sign_in_use_case.dart';
import '../1_domain/usecases/sign_out_use_case.dart';
import '../1_domain/usecases/sign_up_use_case.dart';
import '../2_data/repositories/auth_repository_impl.dart';
import '../4_providers/auth_state_notifier.dart';

/// Service locator for auth feature
final authInjection = GetIt.instance;

/// Initialize auth feature dependencies
Future<void> initAuthDependencies() async {
  // Core
  _initializeCore();

  // Use Cases
  _initializeUseCases();

  // State management
  _initializeStateManagement();
}

/// Initialize core dependencies
void _initializeCore() {
  // Core network and storage services - Rely on core_di for these
  /* // Removed registration block
  if (!authInjection.isRegistered<ConnectivityService>()) {
    authInjection.registerLazySingleton<ConnectivityService>(
      () => ConnectivityService(),
    );
  }

  if (!authInjection.isRegistered<NetworkInfo>()) {
    authInjection.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(authInjection<ConnectivityService>()),
    );
  }

  if (!authInjection.isRegistered<SharedPreferences>()) {
    authInjection.registerLazySingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance(),
    );
  }

  if (!authInjection.isRegistered<FlutterSecureStorage>()) {
    authInjection.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    );
  }

  if (!authInjection.isRegistered<StorageService>()) {
    authInjection.registerLazySingletonAsync<StorageService>(
      () async => StorageServiceImpl(
        sharedPreferences: await authInjection.getAsync<SharedPreferences>(),
        secureStorage: authInjection<FlutterSecureStorage>(),
      ),
    );
  }

  if (!authInjection.isRegistered<DioClient>()) {
    authInjection.registerLazySingleton<DioClient>(
      () => DioClient(core_di.createDioClient()),
    );
  }
  */

  // Repositories - Register feature-specific repositories
  authInjection.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      networkInfo: core_di.sl<NetworkInfo>(), // Get from core_di
      localStorage: core_di.sl<StorageService>(), // Get from core_di
      remote: core_di.sl<DioClient>(), // Get from core_di
    ),
  );
}

/// Initialize use cases
void _initializeUseCases() {
  // Register use cases
  authInjection.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(authInjection<AuthRepository>()),
  );

  authInjection.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(authInjection<AuthRepository>()),
  );

  authInjection.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(authInjection<AuthRepository>()),
  );

  authInjection.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(authInjection<AuthRepository>()),
  );

  authInjection.registerLazySingleton<SendPasswordResetEmailUseCase>(
    () => SendPasswordResetEmailUseCase(authInjection<AuthRepository>()),
  );
}

/// Initialize state management
void _initializeStateManagement() {
  // Register state notifiers
  authInjection.registerLazySingleton<AuthStateNotifier>(
    () => AuthStateNotifier(
      signInUseCase: authInjection<SignInUseCase>(),
      signUpUseCase: authInjection<SignUpUseCase>(),
      signOutUseCase: authInjection<SignOutUseCase>(),
      getCurrentUserUseCase: authInjection<GetCurrentUserUseCase>(),
      sendPasswordResetEmailUseCase:
          authInjection<SendPasswordResetEmailUseCase>(),
    ),
  );
}
