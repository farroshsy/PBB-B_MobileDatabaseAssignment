import 'package:flutter/foundation.dart';
import 'package:my_app/core/usecase/usecase.dart';
import 'package:my_app/core/config/app_config.dart';
import '../../1_domain/usecases/get_app_config_use_case.dart';
import '../../1_domain/usecases/initialize_app_use_case.dart';
import '../../1_domain/usecases/is_authenticated_use_case.dart';
import '../../3_di/splash_injection_container.dart';

/// SplashState enum representing different states of the splash screen
enum SplashState {
  /// Initial state
  initial,
  
  /// Loading state
  loading,
  
  /// Error state
  error,
  
  /// Maintenance mode state
  maintenance,
  
  /// Update required state
  updateRequired,
  
  /// App initialized, ready to navigate
  initialized,
}

/// View model for splash screen
class SplashViewModel extends ChangeNotifier {
  /// Creates a splash view model
  SplashViewModel({
    GetAppConfigUseCase? getAppConfigUseCase,
    InitializeAppUseCase? initializeAppUseCase,
    IsAuthenticatedUseCase? isAuthenticatedUseCase,
  }) : _getAppConfigUseCase = getAppConfigUseCase ?? 
         splashInjection<GetAppConfigUseCase>(),
       _initializeAppUseCase = initializeAppUseCase ?? 
         splashInjection<InitializeAppUseCase>(),
       _isAuthenticatedUseCase = isAuthenticatedUseCase ?? 
         splashInjection<IsAuthenticatedUseCase>();

  final GetAppConfigUseCase _getAppConfigUseCase;
  final InitializeAppUseCase _initializeAppUseCase;
  final IsAuthenticatedUseCase _isAuthenticatedUseCase;
  
  AppConfig? _appConfig;
  bool _isAuthenticated = false;
  SplashState _state = SplashState.initial;
  String? _errorMessage;
  double _progress = 0.0;
  
  /// Current application configuration
  AppConfig? get appConfig => _appConfig;
  
  /// Whether user is authenticated
  bool get isAuthenticated => _isAuthenticated;
  
  /// Current splash state
  SplashState get state => _state;
  
  /// Current error message
  String? get errorMessage => _errorMessage;
  
  /// Initialization progress (0.0 to 1.0)
  double get progress => _progress;
  
  /// Initialize app
  Future<void> initialize() async {
    _setState(SplashState.loading);
    
    // First get app config
    _updateProgress(0.2);
    final configResult = await _getAppConfigUseCase(NoParams());
    
    final configSuccess = configResult.fold(
      (failure) {
        _setError(failure.message);
        return false;
      },
      (config) {
        _appConfig = config;
        
        // Check if app is in maintenance mode using the new getter
        if (config.isInMaintenance) { 
          _setState(SplashState.maintenance);
          return false;
        }
        
        // Check if update is required using the new getter
        if (config.requiresUpdate) { 
          _setState(SplashState.updateRequired);
          return false;
        }
        
        return true;
      },
    );
    
    if (!configSuccess) return;
    
    // Initialize app services and preload assets
    _updateProgress(0.4);
    final initializeResult = await _initializeAppUseCase(NoParams());
    
    final initializeSuccess = initializeResult.fold(
      (failure) {
        _setError(failure.message);
        return false;
      },
      (success) {
        return success;
      },
    );
    
    if (!initializeSuccess) return;
    
    // Check if user is authenticated
    _updateProgress(0.8);
    final authResult = await _isAuthenticatedUseCase(NoParams());
    
    authResult.fold(
      (failure) {
        _isAuthenticated = false;
      },
      (isAuthenticated) {
        _isAuthenticated = isAuthenticated;
      },
    );
    
    // Complete initialization
    _updateProgress(1.0);
    _setState(SplashState.initialized);
  }
  
  /// Get the next route to navigate to
  String getNextRoute() {
    if (state == SplashState.maintenance) {
      return '/maintenance';
    }
    
    if (state == SplashState.updateRequired) {
      return '/update';
    }
    
    if (state == SplashState.initialized) {
      return _isAuthenticated ? '/home' : '/auth/login';
    }
    
    return '/splash';
  }
  
  void _setState(SplashState newState) {
    _state = newState;
    notifyListeners();
  }
  
  void _updateProgress(double value) {
    _progress = value;
    notifyListeners();
  }
  
  void _setError(String message) {
    _errorMessage = message;
    _setState(SplashState.error);
  }
}
