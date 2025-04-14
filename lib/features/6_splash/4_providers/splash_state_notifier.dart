import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/usecase/usecase.dart';
import 'package:my_app/core/config/app_config.dart';
import 'package:my_app/core/di/injection_container.dart';
import 'package:my_app/features/0_auth/4_providers/auth_state_notifier.dart';
import '../1_domain/usecases/get_app_config_use_case.dart';
import '../1_domain/usecases/initialize_app_use_case.dart';
import '../1_domain/usecases/is_authenticated_use_case.dart';

/// Enumeration of splash states
enum SplashStatus {
  /// Initial state
  initial,
  
  /// Loading state
  loading,
  
  /// Success state ready to navigate
  success,
  
  /// Error state
  error,
  
  /// Maintenance state
  maintenance,
  
  /// Update required state
  updateRequired,
}

/// Splash state class containing all the splash state
class SplashState {
  /// Creates a splash state
  const SplashState({
    this.status = SplashStatus.initial,
    this.appConfig,
    this.isAuthenticated = false,
    this.errorMessage,
    this.isLoading = false,
  });

  /// Current status of the splash flow
  final SplashStatus status;
  
  /// App configuration
  final AppConfig? appConfig;
  
  /// Whether user is authenticated
  final bool isAuthenticated;
  
  /// Error message if any
  final String? errorMessage;
  
  /// Whether splash is loading
  final bool isLoading;

  /// Creates a copy of the state with specified fields updated
  SplashState copyWith({
    SplashStatus? status,
    AppConfig? appConfig,
    bool? isAuthenticated,
    String? errorMessage,
    bool? isLoading,
    bool clearError = false,
  }) {
    return SplashState(
      status: status ?? this.status,
      appConfig: appConfig ?? this.appConfig,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// Splash state notifier that manages the splash state
class SplashStateNotifier extends StateNotifier<SplashState> {
  /// Creates a splash state notifier
  SplashStateNotifier({
    required GetAppConfigUseCase getAppConfigUseCase,
    required InitializeAppUseCase initializeAppUseCase,
    required IsAuthenticatedUseCase isAuthenticatedUseCase,
  }) : _getAppConfigUseCase = getAppConfigUseCase,
       _initializeAppUseCase = initializeAppUseCase,
       _isAuthenticatedUseCase = isAuthenticatedUseCase,
       super(const SplashState());

  final GetAppConfigUseCase _getAppConfigUseCase;
  final InitializeAppUseCase _initializeAppUseCase;
  final IsAuthenticatedUseCase _isAuthenticatedUseCase;
  
  /// Initialize application
  Future<void> initialize() async {
    print("[Splash] Initializing...");
    state = state.copyWith(isLoading: true, status: SplashStatus.loading, clearError: true);
    
    print("[Splash] Getting App Config...");
    final appConfigEither = await _getAppConfigUseCase(const NoParams());
    
    await appConfigEither.fold(
      (failure) {
        print("[Splash] Error getting App Config: ${failure.message}");
        state = state.copyWith(
          status: SplashStatus.error,
          errorMessage: failure.message,
          isLoading: false,
        );
      },
      (appConfig) async {
        print("[Splash] App Config loaded successfully.");
        // Check if app is in maintenance
        if (appConfig.isInMaintenance) {
          print("[Splash] App is in maintenance mode.");
          state = state.copyWith(
            status: SplashStatus.maintenance,
            appConfig: appConfig,
            isLoading: false,
          );
          return;
        }
        
        // Check if app requires update
        if (appConfig.requiresUpdate) {
          print("[Splash] App requires update.");
          state = state.copyWith(
            status: SplashStatus.updateRequired,
            appConfig: appConfig,
            isLoading: false,
          );
          return;
        }
        
        print("[Splash] Initializing App...");
        final initResult = await _initializeAppUseCase(const NoParams());
        
        await initResult.fold(
          (failure) {
            print("[Splash] Error initializing app: ${failure.message}");
            state = state.copyWith(
              status: SplashStatus.error,
              errorMessage: failure.message,
              isLoading: false,
            );
          },
          (success) async {
            print("[Splash] App initialized successfully.");
            print("[Splash] Checking authentication...");
            final authEither = await _isAuthenticatedUseCase(const NoParams());
            
            authEither.fold(
              (failure) {
                print("[Splash] Error checking authentication: ${failure.message}");
                state = state.copyWith(
                  status: SplashStatus.error,
                  errorMessage: failure.message,
                  isLoading: false,
                );
              },
              (isAuthenticated) {
                print("[Splash] Authentication check complete: $isAuthenticated");
                // Set splash state to success FIRST
                state = state.copyWith(
                  status: SplashStatus.success,
                  isAuthenticated: isAuthenticated,
                  appConfig: appConfig,
                  isLoading: false,
                );
                print("[Splash] Splash state set to Success.");
                // THEN update the central AuthStateNotifier
                sl<AuthStateNotifier>().updateAuthFromSplash(isAuthenticated); 
                print("[Splash] AuthStateNotifier updated.");
              },
            );
          },
        );
      },
    );
  }
}